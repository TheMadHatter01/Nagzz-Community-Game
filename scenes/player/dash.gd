class_name Dash
extends BaseState

signal dash_ended

onready var dash_timer = $DashTimer
onready var dash_duration = _player.DASH_DURATION


func _enter():
	._enter()
	start_dash(dash_duration)
	dash_direction()


func _exit():
	._exit()


func _update(delta: float):
	._update(delta)
	_player.move_player(delta)


func dash_direction():
	var dash_direction = _player.get_move_input_direction()
	_player.velocity.x = _player.DASH_SPEED * dash_direction


func start_dash(duration: float):
	dash_timer.wait_time = duration
	dash_timer.start()


func is_dashing():
	return !dash_timer.is_stopped()


func end_dash():
	_player.can_dash = false
	emit_signal("dash_ended")
	if _player.is_on_floor():
		_state_machine.transition_to(_state_machine.State.ON_GROUND)
	else:
		_state_machine.transition_to(_state_machine.State.IN_AIR)


func _on_DashTimer_timeout():
	end_dash()
