extends "res://scenes/powerups/base_powerup.gd"

const FIRE_RATE_INCREASE := 1.50
const FIRE_RATE_INCREASE_TIME_SEC := 0.5

var _fire_rate_mult = null
var _timer = Timer.new() as Timer


func _init(player).(player):
	_timer.one_shot = true
	_timer.connect("timeout", self, "_on_timeout")


func _on_pickup():
	print("Picked 'Fire rate incease on reload' powerup")
	_fire_rate_mult = _player.weapon.current_weapon.get_node(@"FireRateMult")
	# Have to add it to tree so it can run.
	_fire_rate_mult.add_child(_timer)


func _on_reload():
	if not _timer.is_stopped():
		_fire_rate_mult.fire_rate_mult /= FIRE_RATE_INCREASE
		_timer.stop()


func _on_reload_finished():
	if not _fire_rate_mult:
		return

	_fire_rate_mult.fire_rate_mult *= FIRE_RATE_INCREASE
	_timer.start(FIRE_RATE_INCREASE_TIME_SEC)


func _on_timeout():
	_fire_rate_mult.fire_rate_mult /= FIRE_RATE_INCREASE
