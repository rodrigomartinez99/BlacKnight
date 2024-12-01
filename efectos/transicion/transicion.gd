extends CanvasLayer

@onready var animation: AnimationPlayer = $AnimationPlayer

# Función de inicialización
func _ready():
	visible = false # Al iniciar el canvas no se debe ver
	self.process_mode = Node.PROCESS_MODE_ALWAYS

# Función de cambio de escena: target es la ruta hacia la escena a cargar
func change_scene(target: String):
	# Mostramos el canvas y mostramos animación (desde transparente hacia un color)
	visible = true
	animation.play("dissolve")
	# Esperamos a que termine la animación
	await animation.animation_finished
	# Cargamos la escena
	get_tree().change_scene_to_file(target)
	# Mostramos animación (desde un color hacia transparente)
	animation.play_backwards("dissolve")
	# Esperamos a que termine la animación
	await animation.animation_finished
	animation.stop()
	# Volvemos a ocultar el canvas
	visible = false


# Función de reiniciar la escena actual
func reload_scene():
	#HealthDashboard.visible = true
	#HealthDashboard.restart()
	# Reiniciamos la escena
	get_tree().reload_current_scene()
