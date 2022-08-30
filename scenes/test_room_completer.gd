extends Node2D


func _ready() -> void:
	var parent = get_parent() as BaseRoom
	assert(parent)

	var err = $Interactable.connect("interacted", self, "on_interacted")
	assert(err == OK)


func on_interacted(_player):
	get_parent().on_room_completed()
