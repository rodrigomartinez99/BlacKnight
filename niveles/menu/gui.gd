extends CanvasLayer

func _process(delta):
	$Container/Label2.text = "SCORE: " + str(GLOBAL.score)

func game_over() -> void:
	get_tree().paused=true
	$ColorRect/VBoxContainer/HBoxContainer/Button.grab_focus()
	
	var tween: Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property($ColorRect,"modulate",Color(1, 1, 1,  0.8),1.0)
	$ColorRect/AudioStreamPlayer2D.play()

func _on_button_pressed():
	Transicion.reload_scene()


func _on_button_2_pressed():
	Transicion.change_scene("res://niveles/menu/menu.tscn")
