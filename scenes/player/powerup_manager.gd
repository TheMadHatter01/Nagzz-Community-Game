extends Node

const Projectile := preload("res://scenes/projectiles/projectile.gd")
const BasePowerup := preload("res://scenes/powerups/base_powerup.gd")
const ReloadIndicator = preload("res://scenes/player/reload_anim.gd")

# Array of res://scenes/powerups/base_powerup.gd
var powerups := []

onready var _player := self.get_parent() as Player


func _ready():
	call_deferred("connect_singals")


# props : PowerupCardProps
func add_powerup(variant: int, props):
	assert(props)
	var powerup = PowerupDatabase.variant_to_script[variant].new(_player) as BasePowerup
	powerups.append(powerup)
	powerup._on_pickup()


func connect_singals():
	var reload_indicator = _player.get_node("ReloadIndicator") as ReloadIndicator
	reload_indicator.connect("reload_started", self, "_on_reload")
	reload_indicator.connect("reload_finished", self, "_on_reload_finished")


func update(delta: float):
	for powerup in powerups:
		powerup._on_update(delta)


func clear_powerups():
	powerups = []


func _on_reload():
	for powerup in powerups:
		powerup._on_reload()


func _on_reload_finished():
	for powerup in powerups:
		powerup._on_reload_finished()


# TODO connect
func _on_shot(_projectile: Projectile):
	pass


# TODO connect
func _on_miss(_projectile: Projectile):
	pass


# TODO connect
func _on_enemy_hit(_enemy: Node2D, _projectile: Projectile):
	pass
