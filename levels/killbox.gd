extends Area2D

func _on_body_entered(body):
	print("player hit killbox")
	body.take_damage(3)
