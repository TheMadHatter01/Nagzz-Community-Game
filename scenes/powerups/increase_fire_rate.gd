extends "res://scenes/powerups/base_powerup.gd"

const FIRE_RATE_INCREASE := 1.15

var _fire_rate_mult = null


func _init(player).(player):
	pass


func _on_pickup():
	print("Picked 'Incease fire rate' powerup")
	_fire_rate_mult = _player.weapon.current_weapon.get_node(@"FireRateMult")
	if _fire_rate_mult:
		_fire_rate_mult.fire_rate_mult *= FIRE_RATE_INCREASE
