extends Control


func _ready():
	pass


func _on_Start_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	var err = get_tree().change_scene("res://scenes/hub/hub.tscn")
	if err != OK:
		push_error("Failed to change scene to hub.")


func _on_Options_pressed():
	pass


func _on_Credits_pressed():
	pass


func _on_Quit_pressed():
	get_tree().quit()


func _on_TestScene_pressed() -> void:
	var err = get_tree().change_scene("res://scenes/test_scene.tscn")
	if err != OK:
		push_error("Failed to change scene to test scene.")
