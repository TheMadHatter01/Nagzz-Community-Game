tool
extends Node2D

const Interactable := preload("res://scenes/interactable/interactable.gd")

export(PackedScene) var scene_to_load

onready var _interactable := get_parent().get_node(@"Interactable")


func _ready():
	assert(_interactable != null, "No Interactable Node")

	if _interactable.connect("interacted", self, "_on_Interactable_interacted") != OK:
		push_error(
			str("node ", get_path(), " couldn't connect to Interactable's interacted signal")
		)


func _on_Interactable_interacted(_player: Player):
	if scene_to_load != null:
		var res = get_tree().change_scene_to(scene_to_load)
		assert(res == OK)
