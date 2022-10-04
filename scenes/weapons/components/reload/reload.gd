extends Node

const Ammo := preload("../ammo/ammo.gd")
const ReloadAnim := preload("res://scenes/player/reload_anim.gd")
const ReloadSpeedMult := preload("../multipliers/reload_speed_mult/reload_speed_mult.gd")

# in seconds
export var base_reload_time := 0.0
# -1 means reload to max
export var reload_ammo_amount: int = -1

var reloading := false

onready var _player := find_parent("Player") as Player
onready var _weapon := get_parent() as Node2D
onready var _ammo := _weapon.get_node("Ammo") as Ammo
onready var _sprite := _weapon.get_node("AnimatedSprite") as AnimatedSprite
onready var _reload_indicator := _player.get_node("ReloadIndicator") as ReloadAnim
onready var _reload_speed_mult := _weapon.get_node("ReloadSpeedMult") as ReloadSpeedMult


func _ready():
	assert(_player)
	assert(_weapon)
	assert(_ammo)
	assert(_reload_indicator)
	assert(base_reload_time >= 0)
	assert(reload_ammo_amount >= -1)

	var conn_err := _reload_indicator.connect("reload_finished", self, "_on_reload_finished")
	if conn_err != OK:
		push_error("Failed to connect to reload signal.")


func _physics_process(_delta):
	if Input.is_action_just_pressed("reload"):
		reload()


func _notification(what):
	# _reload_indicator could be invalid when quiting the game
	if what == NOTIFICATION_PREDELETE and is_instance_valid(_reload_indicator):
		_reload_indicator.stop_reload()


func reload():
	if reloading:
		return

	reloading = true
	var reload_time := _get_reload_time()
	_reload_indicator.run_reload(reload_time)
	_play_reload_amination(reload_time)


func _play_reload_amination(reload_time: float):
	_sprite.stop()
	var frame_count = _sprite.frames.get_frame_count("reloading")
	_sprite.frames.set_animation_speed("reloading", frame_count / reload_time)
	_sprite.play("reloading")
	_sprite.frame = 0


func _on_reload_finished():
	if reload_ammo_amount == -1:
		_ammo.set_max()
	else:
		_ammo.add_ammo(reload_ammo_amount)
	reloading = false


func _get_reload_time() -> float:
	return base_reload_time / _get_reload_speed_mult()


func _get_reload_speed_mult() -> float:
	if _reload_speed_mult:
		return _reload_speed_mult.reload_speed_mult

	return 1.0
