extends CharacterBody2D
class_name Fantasma

@export_category("Config")
@export_group("Opciones")
@export var health_ojo: int = 5
@export var score_ojo: int = 200

@export_group("Movimiento")
@export var speed_ojo: int = 16
@export var gravity_ojo: int = 16

var direction: int = 1

func _process(_delta):
	if health_ojo > 0:
		motion_ctrl()
		
func motion_ctrl() -> void:
	$AnimatedSprite2D.scale.x = direction
	
	if not $AnimatedSprite2D/RayCast2D.is_colliding() or is_on_wall():
		direction *= -1   
		
	velocity.x = direction*speed_ojo
	velocity.y += gravity_ojo
	move_and_slide()
	
func damage_ctrl(damage: int)->void:
	health_ojo-=damage
	if health_ojo <= 0:
		$forma.set_deferred("disabled",true)
		gravity_ojo = 0
		GLOBAL.score += score_ojo
		queue_free()
		
func _on_area_2d_body_entered(body):
	if body is Player and health_ojo > 0:
		body.damage_ctrl()

func _on_deteccion_body_entered(body):
	if body is Player:	
		$AnimatedSprite2D.set_animation("fantasma-ataque")	
		

func _on_deteccion_body_exited(body):
	if not body:
		$AnimatedSprite2D.set_animation("fantasma-walk")
