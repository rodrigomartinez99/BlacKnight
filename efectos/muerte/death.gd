extends Area2D

func _on_body_entered(body):
	if body is Player:
		body.damage_ctrl()
	elif body is Enemy:
		body.damage_ctrl(1)
	elif body is Orco:
		body.damage_ctrl(1)
	elif body is Fantasma:
		body.damage_ctrl(1)
	elif body is Orco:
		body.damage_ctrl(1)
