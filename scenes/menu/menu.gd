extends Control


func _ready():
	pass


func _on_Start_pressed():
	var err = get_tree().change_scene("res://scenes/test_scene.tscn")
	if err != OK:
		push_error("Failed to change scene")


func _on_Options_pressed():
	pass


func _on_Credits_pressed():
	pass


func _on_Quit_pressed():
	get_tree().quit()
