extends Node2D

var current_weapon: Node2D = null


func pickup_weapon(weapon_scene_path: String):
	clear_weapon()
	current_weapon = load(weapon_scene_path).instance() as Node2D
	self.add_child(current_weapon)
	assert(current_weapon != null)


func clear_weapon():
	if current_weapon != null:
		current_weapon.queue_free()
