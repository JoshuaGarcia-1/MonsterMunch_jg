extends Area2D

func _on_body_entered(body):
	print("player is hit")
	body.take_damage(1)
