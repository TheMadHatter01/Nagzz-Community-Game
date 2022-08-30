extends Node2D

export var area_name: String = ""


func _ready() -> void:
	if $Interactable.connect("interacted", self, "on_interacted") != OK:
		push_error(self.get_class().get_file() + ": Failed to connect to Interactable")


func on_interacted(_player):
	GameManager.enter_area(area_name)
