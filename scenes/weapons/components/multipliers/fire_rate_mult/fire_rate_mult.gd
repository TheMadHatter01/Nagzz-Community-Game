extends Node

export var fire_rate_mult := 1.0 setget set_fire_rate_mult


func set_fire_rate_mult(new_fire_rate_mult: float):
	print("Fire rate mult: ", new_fire_rate_mult)
	fire_rate_mult = new_fire_rate_mult
