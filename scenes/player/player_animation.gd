extends AnimatedSprite

onready var _player = get_parent() as Player


func update_animation():
	match _player._state_machine.current_state:
		StateMachine.State.ON_GROUND:
			if _player.velocity.x == 0:
				play("idle")
			else:
				play("run")
		_:
			pass

	if _player.velocity.x < 0:
		flip_h = true
	elif _player.velocity.x > 0:
		flip_h = false
