extends Node2D

@export var enemy_scenes: Array[PackedScene] = []

func _ready():
	GLOBAL.score+=0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	$Path2D/PathFollow2D.set_progress($Path2D/PathFollow2D.get_progress()+80*delta)
	

func _on_timer_timeout():
	var random_enemy_scene = enemy_scenes[randi() % enemy_scenes.size()]
	var enemy_instance = random_enemy_scene.instantiate()
	enemy_instance.global_position = $Path2D/PathFollow2D.global_position
	add_child(enemy_instance)
