tool
extends Area2D

export var texture: StreamTexture setget set_texture
export var speed: float = 1500.0
export var damage: float = 10.0

var _velocity: Vector2


func _physics_process(delta: float):
	global_position += _velocity * delta


func init(initial_position: Vector2, angle: float):
	$Sprite.set_texture(texture)
	global_position = initial_position
	_velocity = Vector2(speed, 0).rotated(angle)
	rotation = angle


func set_texture(new_texture: StreamTexture):
	texture = new_texture


func _destroy():
	queue_free()


func _on_Projectile_area_entered(_area):
	_destroy()


func _on_Projectile_body_entered(_body):
	_destroy()


func _on_VisibilityNotifier2D_screen_exited():
	_destroy()
