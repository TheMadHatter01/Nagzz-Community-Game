extends "res://scenes/areas/base_area.gd"


func _get_name() -> String:
	return "test_area"


func _get_rooms() -> Array:
	return [
		"res://scenes/areas/test_area/test_room_1.tscn",
		"res://scenes/areas/test_area/test_room_2.tscn"
	]
