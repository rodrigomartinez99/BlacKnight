extends CharacterBody2D
class_name Orco

@export_category("Config")
@export_group("Opciones")
@export var health_orco: int = 3
@export var score_orco: int = 100

@export_group("Movimiento")
@export var speed_orco: int = 16
@export var gravity_orco: int = 16

var direction: int = 1

func _process(_delta):
	if health_orco > 0:
		motion_ctrl()
		
func motion_ctrl() -> void:
	$AnimatedSprite2D.scale.x = direction
	
	if not $AnimatedSprite2D/RayCast2D.is_colliding() or is_on_wall():
		direction *= -1   
		
	velocity.x = direction*speed_orco
	velocity.y += gravity_orco
	move_and_slide()
	
func damage_ctrl(damage: int)->void:
	health_orco-=damage
	if health_orco <= 0:
		$forma.set_deferred("disabled",true)
		gravity_orco = 0
		GLOBAL.score += score_orco
		$AnimatedSprite2D.set_animation("death-orc")
		await $AnimatedSprite2D.animation_finished
		queue_free()
		
func _on_area_2d_body_entered(body):
	if body is Player:	
		$AnimatedSprite2D.set_animation("ataque1-orc")
		

func _on_deteccion_body_entered(body):
	if body is Player and health_orco > 0:
		body.damage_ctrl()
		

func _on_deteccion_body_exited(body):
	if not body:
		$AnimatedSprite2D.set_animation("orc-walk")
