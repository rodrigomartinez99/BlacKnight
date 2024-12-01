extends CharacterBody2D
class_name Player

var axis: Vector2 = Vector2.ZERO
var death: bool = false

@export_category("Config")
@export_group("Referencias")
@export var gui: CanvasLayer

@export_group("Movimiento")
@export var speed: int = 128
@export var jump_force: int = 368
@export var gravity: int = 16

func _physics_process(_delta):
	match death:
		true:
			death_ctrl()
		false:
			motion_ctrl()
			
func _input(event):
		if not death and is_on_floor() and event.is_action_pressed("saltar"):
			jumpl_ctrl(1)
		if event.is_action_pressed("attack1") and not death:
			attack_ctrl()
			
func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("derecha")) - int(Input.is_action_pressed("izquierda"))
	return axis.normalized()
	
func motion_ctrl() -> void:
	'''Movimientos'''
	if not get_axis().x == 0:
		$AnimatedSprite2D.flip_h = get_axis().x < 0
		
	velocity.x = get_axis().x*speed
	velocity.y += gravity
	move_and_slide()
	
	'''Animaciones'''
	match is_on_floor():
		true:
			if not get_axis().x == 0:
				$AnimatedSprite2D.set_animation("walk")
			else:
				$AnimatedSprite2D.set_animation("idle")
				
func attack_ctrl():
	$Area2D.monitoring = true  # Activar el área de ataque
	$AnimatedSprite2D.set_animation("ataque1")

func death_ctrl() -> void:
	death=true
	$AnimatedSprite2D.set_animation("muerto")	
	
func jumpl_ctrl(power: float)->void:
	velocity.y=-jump_force*power
	$Node/salto.play()
	
func damage_ctrl()->void:	
	$AnimatedSprite2D.set_animation("hurt")
	

func _on_area_2d_body_entered(body):
	if body is Enemy:
		$Node/ataque.play()		
		body.damage_ctrl(1)
		jumpl_ctrl(0.75) 

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "muerto":
		gui.game_over()
		queue_free()
	elif $AnimatedSprite2D.animation.startswith("ataque1"):
		$Area2D.monitoring = false
