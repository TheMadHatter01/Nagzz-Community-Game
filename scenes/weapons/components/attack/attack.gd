extends Node

const FireRateMult := preload("../multipliers/fire_rate_mult/fire_rate_mult.gd")
const Ammo := preload("../ammo/ammo.gd")
const Reload := preload("../reload/reload.gd")

# like projectile or maybe a melee attack
export var attack_scene: PackedScene
export var attack_speed := 0.0
export var shot_sound: AudioStreamSample

var _last_attack_time := 0.0

onready var _attack_point := $"../AttackPoint" as Position2D
onready var _player := find_parent("Player") as Player
onready var _sprite := $"../AnimatedSprite" as AnimatedSprite
onready var _weapon := self.get_parent()
onready var _ammo := _weapon.get_node("Ammo") as Ammo
onready var _reload := _weapon.get_node("Reload") as Reload
onready var _fire_rate_mult := _weapon.get_node(@"FireRateMult") as FireRateMult
onready var _audio := $Audio as AudioStreamPlayer


func _ready():
	assert(attack_scene != null)
	assert(attack_speed >= 0.0)
	assert(shot_sound != null)
	assert(_sprite != null)

	_sprite.play("default")
	if _sprite.connect("animation_finished", self, "_shoot_animation_finished") != OK:
		push_error("Failed to connect to weapon animation")

	_audio.stream = shot_sound


func _physics_process(delta: float):
	_last_attack_time += delta
	var attack_speed_per_sec = _get_attack_speed()

	if Input.is_action_pressed("attack") and _last_attack_time >= attack_speed_per_sec:
		_last_attack_time = 0.0
		_attack(attack_speed_per_sec)


func _shoot_animation_finished():
	if _ammo and not _ammo.has_ammo_left():
		_reload.reload()
	else:
		_sprite.play("default")


func _attack(attack_speed_per_sec: float):
	assert(_player)

	if _reload and _reload.reloading:
		return

	if _ammo:
		if not _ammo.has_ammo_left():
			_reload.reload()
			return
		_ammo.ammo -= 1

	var attack := attack_scene.instance() as Node2D
	var initial_position := _get_attack_point()

	attack.init(
		initial_position,
		_player.global_position.direction_to(_player.get_global_mouse_position()).angle()
	)
	_player.get_tree().current_scene.add_child(attack)

	_play_shot_amination(attack_speed_per_sec)
	_play_shot_sound()


func _play_shot_amination(attack_speed_per_sec: float):
	_sprite.stop()
	var frame_count = _sprite.frames.get_frame_count("shooting")
	_sprite.frames.set_animation_speed("shooting", frame_count / attack_speed_per_sec)
	_sprite.play("shooting")
	_sprite.frame = 0


func _play_shot_sound():
	if !_audio.playing:
		_audio.play()
	else:
		var audio_player: AudioStreamPlayer = _audio.duplicate(DUPLICATE_USE_INSTANCING)
		get_parent().add_child(audio_player)
		audio_player.stream = _audio.stream
		audio_player.play()
		if audio_player.connect("finished", audio_player, "queue_free") != OK:
			push_error("Failed to connect shot sound audio player to queue_free.")


func _get_attack_point() -> Vector2:
	if _attack_point != null:
		return _attack_point.global_position
	return _player.global_position


func _get_attack_speed():
	var attack_speed_mult := _fire_rate_mult.fire_rate_mult if _fire_rate_mult != null else 1.0
	return attack_speed / attack_speed_mult
