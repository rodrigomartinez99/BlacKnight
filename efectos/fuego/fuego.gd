extends RigidBody2D

func ready():
	self.set_deferred("freeze", true)
	self.set_deferred("sleeping", true)
	self.set_deferred("linear_velocity.x", 0)
	self.set_deferred("linear_velocity.y", 0)
	self.set_deferred("gravity_scale", 0)

func _on_body_entered(body):
	$AnimatedSprite2D.play("bolafuego")
	if body is Player:
		body.damage_ctrl()
	if body is Enemy:
		body.damage_ctrl(1)
	elif body is Orco:
		body.damage_ctrl(3)
	elif body is Fantasma:
		body.damage_ctrl(5)
