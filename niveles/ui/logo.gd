extends Node2D

@onready var animationplayer: AnimationPlayer = $AnimationPlayer
# Ruta a la escena a cargar cuando finalice el "splash"
var _path_map_scene = "res://niveles/menu/menu.tscn"


func _ready():
	#HealthDashboard.visible = false
	# Mostramos el logo de Endless
	animationplayer.play("do_splash")

# Escuchamos el teclado
func _input(event):
	# Escuchamos si se preciona algun boton
	if event is InputEventKey:
		# Llamamos el la función de cambio de escena
		_go_title_screen()

func _go_title_screen():
	# Pasamos a la escena de Menú principal
	SceneTransicion.change_scene(_path_map_scene)

func _on_animation_player_animation_finished(anim_name):
	_go_title_screen()
