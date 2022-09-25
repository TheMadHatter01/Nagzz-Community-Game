extends Node2D

var current_weapon: Node2D = null
var cursor = load("res://scenes/player/cursor.png")


func pickup_weapon(weapon_scene_path: PackedScene):
	clear_weapon()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(16, 16))
	current_weapon = weapon_scene_path.instance()
	self.add_child(current_weapon)
	assert(current_weapon != null)


func clear_weapon():
	if current_weapon != null:
		current_weapon.queue_free()
