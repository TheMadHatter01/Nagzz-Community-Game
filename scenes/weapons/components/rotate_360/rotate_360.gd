extends Node

var _attack_point: Position2D = null

onready var _weapon := get_parent() as Node2D
onready var _player := find_parent("Player")


func _ready():
	assert(_weapon != null)
	assert(_player != null)


func _physics_process(_delta):
	var mouse_pos := _weapon.get_global_mouse_position()
	_weapon.look_at(mouse_pos)
	# Mirror weapon sprite if facing left.
	#_weapon.scale.y = -1 if _player.global_position.x - mouse_pos.x > 0 else 1
