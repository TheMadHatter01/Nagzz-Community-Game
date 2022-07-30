extends Node

const FireRateMult := preload("../multipliers/fire_rate_mult/fire_rate_mult.gd")
const Ammo := preload("../ammo/ammo.gd")
const Reload := preload("../reload/reload.gd")

# like projectile or maybe a melee attack
export var attack_scene: PackedScene
export var attack_speed := 0.0

var _last_attack_time := 0.0

onready var _attack_point := $"../AttackPoint" as Position2D
onready var _player := find_parent("Player") as Player
onready var _sprite := $"../AnimatedSprite" as AnimatedSprite
onready var _weapon := self.get_parent()
onready var _ammo := _weapon.find_node("Ammo") as Ammo
onready var _reload := _weapon.find_node("Reload") as Reload


func _ready():
	assert(attack_scene != null)
	assert(attack_speed >= 0.0)
	assert(_sprite != null)


func _physics_process(delta: float):
	_last_attack_time += delta

	if Input.is_action_pressed("attack") and _last_attack_time >= _get_attack_speed():
		_last_attack_time = 0.0
		_attack()


func _attack():
	assert(_player)

	if _reload and _reload.reloading:
		return

	if _ammo:
		if not _ammo.has_ammo_left():
			_reload.reload()
			return

		_ammo.ammo -= 1

		if not _ammo.has_ammo_left():
			_reload.reload()

	var attack := attack_scene.instance() as Node2D
	var initial_position := _get_attack_point()

	attack.init(
		initial_position,
		_player.global_position.direction_to(_player.get_global_mouse_position()).angle()
	)
	_player.get_tree().current_scene.add_child(attack)


func _get_attack_point() -> Vector2:
	if _attack_point != null:
		return _attack_point.global_position

	return _player.global_position


func _get_attack_speed():
	var attack_speed_mult_node := _weapon.find_node("FireRateMult") as FireRateMult

	var attack_speed_mult := (
		attack_speed_mult_node.fire_rate_mult
		if attack_speed_mult_node != null
		else 1.0
	)

	return attack_speed / attack_speed_mult
