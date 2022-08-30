extends Node2D

#var a = 6

#func _get_property_list() -> Array:
#	return [{
#		"name": "a","type": TYPE_INT
#	}]

#func _ready() -> void:
#	print(get_children())
#	a = 32434
#	var file = File.new()
#	file.open("save_game", File.WRITE)
#	file.store_var(self, true)
#	file.close()
#
#	file = File.new()
#	file.open("save_game", File.READ)
#	var tmp : Node2D = file.get_var(true)
#	print(tmp.a)
#	print(tmp.get_children())
#	file.close()
