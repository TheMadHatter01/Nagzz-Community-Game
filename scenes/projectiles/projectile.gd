extends Area2D

const SPEED := 1500.0

export var damage: int = 10

var _velocity: Vector2


func _physics_process(delta: float):
	global_position += _velocity * delta


func init(initial_position: Vector2, angle: float):
	global_position = initial_position
	_velocity = Vector2(SPEED, 0).rotated(angle)
	rotation = angle


func _destroy():
	queue_free()


func _on_Projectile_area_entered(_area):
	_destroy()


func _on_Projectile_body_entered(_body):
	_destroy()


func _on_VisibilityNotifier2D_screen_exited():
	_destroy()
