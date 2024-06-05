extends Control



func _on_start_pressed():
	get_tree().change_scene_to_file("res://levels/test.tscn")


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://menus/credits.tscn")


func _on_exit_pressed():
	get_tree().quit()
