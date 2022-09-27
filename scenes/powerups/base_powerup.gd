extends Node

const Projectile = preload("res://scenes/projectiles/projectile.gd")

var _player: Player = null


func _init(player: Player) -> void:
	assert(player)
	_player = player


func _on_pickup():
	pass


func _on_update(_delta: float):
	pass


func _on_reload():
	pass


func _on_reload_finished():
	pass


func _on_shot(_projectile: Projectile):
	pass


func _on_miss(_projectile: Projectile):
	pass


func _on_enemy_hit(_enemy: Node2D, _projectile: Projectile):
	pass
