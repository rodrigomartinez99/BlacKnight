extends CharacterBody2D

@export var patrol_speed: float = 100.0
@export var chase_speed: float = 150.0
@onready var detection_area: Area2D = $Area2D
@onready var stun_timer: Timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var player_reference: Node = null
var stunned: bool = false

func _process(delta):
	if player_reference and not stunned:
		chase_player()
	else:
		patrol()

func patrol():
	animated_sprite.play("motion")
	move_and_slide()

func chase_player():
	if player_reference:
		animated_sprite.play("run")
		var direction = (player_reference.global_position - global_position).normalized()
		move_and_slide()

func on_detection_area_body_entered(body: Node):
	if body.is_in_group("player"):
		player_reference = body

func on_detection_area_body_exited(body: Node):
	if body == player_reference:
		player_reference = null

func on_stun_timer_timeout():
	stunned = false
	patrol()

