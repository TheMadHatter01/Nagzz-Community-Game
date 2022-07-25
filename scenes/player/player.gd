class_name Player
extends KinematicBody2D

# Consts
const GRAVITY := 1650.0
const JUMP_FORCE := Vector2(50, -850)
const AIR_FRICTION := 250.0
const AIR_MOVE_ACCELERATION := 625.0
# So that the player falls faster than accelerates upwards.
const JUMP_FALL_MULTIPLIER: float = 1.3
# Jump buffer time, in seconds.
const JUMP_BUFFER_TIME_SECS := 0.12  # Rougly 7 frames at 60 FPS.
const JUMP_CUT_FORCE := 200
# Coyote time https://developer.amazon.com/blogs/appstore/post/9d2094ed-53cb-4a3a-a5cf-c7f34bca6cd3/coding-imprecise-controls-to-make-them-feel-more-precise
const COYOTE_TIME_SECS := 0.1

const RUN_MAX_SPEED: float = 300.0

enum MOVE_DIRECTION {
	LEFT = -1,
	NONE = 0,
	RIGHT = 1,
}
# Consts end

onready var _state_machine = $StateMachine

var velocity := Vector2.ZERO


func _ready():
	assert(_state_machine != null)


func _physics_process(delta: float):
	_state_machine.update(delta)


func move_player(_delta: float):
	$VelocityDirectionDebugArrow.look_at(get_global_position() + velocity)
	velocity = self.move_and_slide(velocity, Vector2.UP)


func apply_gravity(delta: float, gravity_mult: float = 1.0):
	velocity.y += GRAVITY * gravity_mult * delta


func add_force(force: Vector2):
	velocity += force


func air_move(delta: float):
	var move_direction = get_move_input_direction()
	velocity.x += AIR_MOVE_ACCELERATION * move_direction * delta
	velocity.x = sign(velocity.x) * min(RUN_MAX_SPEED, abs(velocity.x))


func apply_air_friction(delta: float):
	var movement_direction = sign(velocity.x)
	velocity.x = abs(velocity.x) - AIR_FRICTION * delta
	velocity.x = max(velocity.x, 0)
	velocity.x *= movement_direction


func can_jump() -> bool:
	return self.is_on_floor()


func get_move_input_direction() -> int:
	var move_direction := 0
	if Input.is_action_pressed("move_right"):
		move_direction += MOVE_DIRECTION.RIGHT
	if Input.is_action_pressed("move_left"):
		move_direction += MOVE_DIRECTION.LEFT
	return move_direction
