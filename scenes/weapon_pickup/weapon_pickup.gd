extends Node2D

const WEAPON_PICKUP_GROUP := "weapon_pickup"

export var weapon_scene: PackedScene = null
export var weapon_texture: Texture = null


func _ready():
	add_to_group(WEAPON_PICKUP_GROUP)
	assert(weapon_scene)
	assert(weapon_texture)
	set_weapon(weapon_scene, weapon_texture)


func set_weapon(weapon: PackedScene, texture: Texture):
	self.weapon_texture = texture
	self.weapon_scene = weapon
	$Sprite.texture = weapon_texture
	$Tween.interpolate_property(
		$Sprite, "transform:origin:y", -10, 10, 1.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT
	)
	$Tween.interpolate_property(
		$Sprite, "transform:origin:y", 10, -10, 1.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 1.0
	)
	$Tween.start()


func _on_Interactable_interacted(player: Player) -> void:
	print("Interacted with weapon pickup.")
	var weapon = player.get_node("Weapon")
	assert(weapon)
	weapon.pickup_weapon(weapon_scene)

	for weapon_pickup in get_tree().get_nodes_in_group(WEAPON_PICKUP_GROUP):
		weapon_pickup = weapon_pickup as Node2D
		weapon_pickup.get_node("Tween").start()
		weapon_pickup.get_node("Sprite").visible = true

	$Sprite.visible = false
	$Tween.stop_all()
