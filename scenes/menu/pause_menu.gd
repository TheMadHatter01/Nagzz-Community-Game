extends Control

var _is_paused := false


func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()


func pause():
	_is_paused = true
	get_tree().paused = _is_paused
	visible = _is_paused


func unpause():
	_is_paused = false
	get_tree().paused = _is_paused
	visible = _is_paused


func toggle_pause():
	_is_paused = !_is_paused
	get_tree().paused = _is_paused
	visible = _is_paused


func _on_Resume_button_pressed():
	unpause()


func _on_Quit_button_pressed():
	var err = get_tree().change_scene("res://scenes/menu/menu.tscn")
	if err != OK:
		push_error("Failed to change scene")
	unpause()
