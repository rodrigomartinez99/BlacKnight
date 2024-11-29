extends CharacterBody2D

@export var speed: float = 200
@export var jump_force: float = 400  # Cambié el signo para usar valores positivos
@export var gravity: float = 800.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_area: Area2D = $Area2D
@onready var attack_timer: Timer = $Timer
@onready var ataque: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var salto: AudioStreamPlayer2D = $AudioStreamPlayer2D2

func _physics_process(delta):
	# Aplicar gravedad constante
	velocity.y += gravity * delta

	# Movimiento horizontal
	if Input.is_action_pressed("derecha"):
		velocity.x = speed
		animated_sprite.flip_h = false
		if is_on_floor() and attack_timer.is_stopped():
			animated_sprite.play("walk")
	elif Input.is_action_pressed("izquierda"):
		velocity.x = -speed
		animated_sprite.flip_h = true
		if is_on_floor() and attack_timer.is_stopped():
			animated_sprite.play("walk")
	else:
		velocity.x = 0
		if is_on_floor() and attack_timer.is_stopped():
			animated_sprite.play("idle")

	# Salto
	if is_on_floor() and Input.is_action_just_pressed("saltar"):
		velocity.y = -jump_force  # Salto hacia arriba con fuerza negativa
		animated_sprite.play("jump")
		salto.play()

	# Ataque
	if Input.is_action_just_pressed("attack1") and attack_timer.is_stopped():
		attack()

	# Movimiento del personaje
	move_and_slide()

func attack():
	animated_sprite.play("ataque1")
	ataque.play()
	attack_timer.start()
	attack_area.monitoring = true

func on_attack_area_body_entered(body: Node):
	if body.is_in_group("enemies"):
		body.take_damage()

func on_animation_finished():
	if animated_sprite.animation in ["ataque1", "ataque2"]:
		attack_area.monitoring = false
		if is_on_floor():
			animated_sprite.play("idle")
		else:
			animated_sprite.play("jump")

func on_attack_timer_timeout():
	attack_area.monitoring = false
