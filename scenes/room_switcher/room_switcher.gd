tool
extends Node2D

const Interactable := preload("res://scenes/interactable/interactable.gd")

export(PackedScene) var scene_to_load


func _on_Interactable_interacted(_player: Player):
	if scene_to_load != null:
		var res = get_tree().change_scene_to(scene_to_load)
		assert(res == OK)
