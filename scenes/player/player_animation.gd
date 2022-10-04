extends AnimatedSprite

onready var _player = get_parent() as Player


func update_animation():
	var has_weapon: bool = _player.weapon.current_weapon != null
	var no_arm_suffix: String = "_no_arm" if has_weapon else ""
	match _player._state_machine.current_state:
		StateMachine.State.ON_GROUND:
			if _player.velocity.x == 0:
				play("idle" + no_arm_suffix)
			else:
				play("run" + no_arm_suffix)
		_:
			pass

	if _player.weapon.current_weapon == null:
		if _player.velocity.x < 0:
			flip_h = true
		elif _player.velocity.x > 0:
			flip_h = false
	else:
		var mouse_pos = _player.get_local_mouse_position()
		if mouse_pos.x < 0:
			flip_h = true
			_player.weapon.scale.x = -1
			_player.weapon.position.x = abs(_player.weapon.position.x)
		elif mouse_pos.x > 0:
			flip_h = false
			_player.weapon.scale.x = 1
			_player.weapon.position.x = -abs(_player.weapon.position.x)
