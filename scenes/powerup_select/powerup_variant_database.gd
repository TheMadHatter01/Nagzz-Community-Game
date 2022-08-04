extends Node

enum PowerupVariant {
	CUSTOM = -1,
	TEST1 = 0,
	TEST2 = 1,
}

const ICON_IMAGE := preload("res://icon.png")

# gdlint: ignore=constant-name
const PowerupCardProps = preload("powerup_card.gd").PowerupCardProps

var powerups = [
	PowerupCardProps.new(
		"Test 1",
		"Test 1 powerup's [color=yellow]description[/color]",
		ICON_IMAGE,
		PowerupVariant.TEST1,
		funcref(self, "_test1_on_select")
	),
	PowerupCardProps.new(
		"Test 2",
		"Test 2 powerup's [color=yellow]description[/color]",
		ICON_IMAGE,
		PowerupVariant.TEST2,
		funcref(self, "_test2_on_select")
	)
]


func _test1_on_select(_player: Player):
	print("selected test1")


func _test2_on_select(_player: Player):
	print("selected test2")
