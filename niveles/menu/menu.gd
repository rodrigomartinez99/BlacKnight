extends Control

func _on_play_pressed():
	
	Transicion.change_scene("res://niveles/escena1/scena1.tscn")

func _on_options_pressed():
	Transicion.change_scene("res://niveles/menu/options.tscn")


func _on_quit_pressed():
	get_tree().quit()
	





