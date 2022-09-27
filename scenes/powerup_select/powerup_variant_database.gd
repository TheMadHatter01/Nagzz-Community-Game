extends Node

enum PowerupVariant {
	CUSTOM = -1,
	FIRE_RATE_UP_ON_RELOAD = 0,
	INCREASE_FIRE_RATE = 1,
}

const ICON_IMAGE := preload("res://icon.png")

# gdlint: ignore=constant-name
const PowerupCardProps = preload("powerup_card.gd").PowerupCardProps

var variant_to_props = {
	PowerupVariant.FIRE_RATE_UP_ON_RELOAD:
	PowerupCardProps.new(
		"Fire rate up on reload",
		"Increase fire rate for a short time after reload",
		ICON_IMAGE,
		PowerupVariant.FIRE_RATE_UP_ON_RELOAD
	),
	PowerupVariant.INCREASE_FIRE_RATE:
	PowerupCardProps.new(
		"Increase fire rate",
		"Increases fire rate by 15%",
		ICON_IMAGE,
		PowerupVariant.INCREASE_FIRE_RATE
	)
}

var variant_to_script = {
	PowerupVariant.INCREASE_FIRE_RATE: preload("res://scenes/powerups/increase_fire_rate.gd"),
	PowerupVariant.FIRE_RATE_UP_ON_RELOAD:
	preload("res://scenes/powerups/fire_rate_up_on_reload.gd")
}
