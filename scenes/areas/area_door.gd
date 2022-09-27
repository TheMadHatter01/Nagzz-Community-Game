extends Node2D

export var area_name: String = "" setget set_area_name

onready var _label := get_node("Label") as Label


func _ready() -> void:
	$Label.text = area_name
	if $Interactable.connect("interacted", self, "on_interacted") != OK:
		push_error(self.get_class().get_file() + ": Failed to connect to Interactable")


func on_interacted(_player):
	if _player.weapon.current_weapon:
		GameManager.enter_area(area_name)


func set_area_name(name: String):
	area_name = name
	if _label:
		_label.text = name
