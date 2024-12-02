extends Node2D

@export var enemy: PackedScene

func _ready():
	GLOBAL.score+=0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	$Path2D/PathFollow2D.set_progress($Path2D/PathFollow2D.get_progress()+80*delta)
	

func _on_timer_timeout():
	var enemy_instance = enemy.instantiate()
	enemy_instance.global_position = $Path2D/PathFollow2D.global_position
	add_child(enemy_instance)
