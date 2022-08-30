class_name BaseRoom
extends Node2D


func on_player_spawn():
	# TODO
	pass


func on_room_completed():
	print("Room completed.")
	# TODO select powerup here.
	GameManager.on_room_completed()
