extends Node2D

var current_weapon: Node2D = null


func pickup_weapon(weapon_scene_path: PackedScene):
	clear_weapon()
	current_weapon = weapon_scene_path.instance()
	self.add_child(current_weapon)
	assert(current_weapon != null)


func clear_weapon():
	if current_weapon != null:
		current_weapon.queue_free()
