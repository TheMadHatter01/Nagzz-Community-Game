extends Node

# -1 means infinite
export var base_mag_capacity: int
export var ammo: int


func _ready():
	assert(base_mag_capacity > 0 or base_mag_capacity == -1)

	set_max()


func has_ammo_left() -> bool:
	return ammo > 0 or base_mag_capacity == -1


func set_max():
	ammo = base_mag_capacity


func add_ammo(amount: int):
	ammo = int(min(amount + ammo, base_mag_capacity))
