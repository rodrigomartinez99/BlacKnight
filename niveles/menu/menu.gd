extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://niveles/escena1/scena1.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://niveles/menu/options.tscn")


func _on_quit_pressed():
	get_tree().quit()
	
func show_menu(_show: bool):
	if _show:
		if not visible:
			_toggle_show()
	else:
		if visible:
			_toggle_show()




