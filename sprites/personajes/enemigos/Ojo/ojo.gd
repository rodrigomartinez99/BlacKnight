extends CharacterBody2D
class_name Enemy

@export_category("Config")
@export_group("Opciones")
@export var health: int = 1
@export var score: int = 100

@export_group("Movimiento")
@export var speed: int = 16
@export var gravity: int = 16

var direction: int = 1

func _process(_delta):
	if health > 0:
		motion_ctrl()
		
func motion_ctrl() -> void:
	$AnimatedSprite2D.scale.x = direction
	
	if $AnimatedSprite2D/RayCast2D.is_colliding() or is_on_wall():
		direction *= -1   
		
	velocity.x = direction*speed
	velocity.y += gravity
	move_and_slide()
	
func damage_ctrl(damage: int)->void:
	health-=damage
	if health <= 0:
		$CollisionShape2D.set_deferred("disabled",true)
		gravity = 0
		GLOBAL.score += score 

func _on_area_2d_body_entered(body):
	if body is Player and health > 0:
		body.damage_ctrl()

func _on_deteccion_body_entered(body):
	if body is Player:
		$AnimatedSprite2D.set_animation("ojo-run")
