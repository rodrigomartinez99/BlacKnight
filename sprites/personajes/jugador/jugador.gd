extends CharacterBody2D
class_name Player

@export_category("Config")
@export_group("Referencias")
@export var gui: CanvasLayer

@export_group("Movimiento")
@export var speed: int = 128
@export var jump_force: int = 368
@export var gravity: int = 16

signal attacked_enemy(enemy: Node)

var axis: Vector2 = Vector2.ZERO
var death: bool = false


func _physics_process(_delta):
	$espada/CollisionShape2D.set_deferred("disabled", true)
	match death:
		true:
			death_ctrl()
		false:
			motion_ctrl()
			
func _input(event):
		if not death and is_on_floor() and event.is_action_pressed("saltar"):
			jumpl_ctrl(1)
			
func _unhandled_input(event):
		if event.is_action_pressed("saltar") and event.is_action_released("attack1"):
			attack_ctrl1()
		if event.is_action_released("attack1") :
			attack_ctrl2()
			
func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("derecha")) - int(Input.is_action_pressed("izquierda"))
	return axis.normalized()
	
func motion_ctrl() -> void:
	if not get_axis().x == 0:
		$AnimatedSprite2D.flip_h = get_axis().x < 0
	velocity.x = get_axis().x * speed
	velocity.y += gravity
	move_and_slide()

	if is_on_floor():
		$AnimatedSprite2D.play("walk" if get_axis().x != 0 else "idle")
				
func attack_ctrl1():
	$espada/CollisionShape2D.set_deferred("disabled", false)
	$AnimatedSprite2D.play("ataque1")
	$Node/ataque.play()
	
func attack_ctrl2():
	$espada/CollisionShape2D.set_deferred("disabled", false)
	$AnimatedSprite2D.play("ataque3")
	$Node/ataque.play()

func death_ctrl() -> void:
	velocity.x=0
	velocity.y+=gravity
	move_and_slide()
	
func jumpl_ctrl(power: float)->void:
	velocity.y=-jump_force*power
	$Node/salto.play()
	
func damage_ctrl()->void:	
	death=true
	$AnimatedSprite2D.set_animation("muerto")
	

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "muerto":
		gui.game_over()
		queue_free()

func _on_salto_body_entered(body):
	if body.is_in_group("enemies"):
		emit_signal("attacked_enemy", body)
		$Node/ataque.play()	
		jumpl_ctrl(0.75)
		if body is Enemy:
			body.damage_ctrl(1)
		elif body is Orco:
			body.damage_ctrl(1)
		elif body is Fantasma:
			body.damage_ctrl(1)
		elif body is Orco:
			body.damage_ctrl(1)


func _on_espada_body_entered(body):
	if body.is_in_group("enemies"):
		emit_signal("attacked_enemy", body)
		if body is Enemy:
			body.damage_ctrl(1)
		elif body is Orco:
			body.damage_ctrl(1)
		elif body is Fantasma:
			body.damage_ctrl(1)
		elif body is Orco:
			body.damage_ctrl(1)


func _on_animated_sprite_2d_frame_changed():
	if $AnimatedSprite2D.animation == "ataque1" or "ataque3" and $AnimatedSprite2D.frame==1: 
		$espada/CollisionShape2D.set_deferred("disabled", false)
	else:	
		$espada/CollisionShape2D.set_deferred("disabled", true)	
