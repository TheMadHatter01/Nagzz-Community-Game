extends Node

const PLAYER_NODE := preload("res://scenes/player/player.tscn")

const AREAS := {"test_area": preload("res://scenes/areas/test_area/test_area.gd")}

const POWERUP_SELECT = preload("res://scenes/powerup_select/powerup_select.tscn")

var player: Player = null
var current_run: RunData = null


# TODO extract to a file.
class RunData:
	const MAX_ROOMS_PER_RUN := 5

	var area = null
	var rooms_available := []
	var completed_rooms := 0

	var available_powerups := []
	var max_powerup_select := 3


func _ready() -> void:
	pass


func save_game():
	# TODO
	pass


func load_game():
	# TODO
	pass


func spawn_player(position: Position2D):
	if not player:
		player = PLAYER_NODE.instance()
	position.get_parent().add_child(player)
	player.position = position.position
	player.call_deferred("set_owner", position.get_tree().root)


func go_to_hub():
	player = null
	var err = get_tree().change_scene("res://scenes/hub/hub.tscn")
	if err != OK:
		push_error("Failed to change scene to hub.")


func enter_area(area_name: String):
	if not OS.is_debug_build():
		randomize()

	current_run = RunData.new()
	print("Enter area: ", area_name)
	assert(area_name in AREAS)

	current_run.area = AREAS[area_name].new() as BaseArea
	assert(current_run.area)
	current_run.rooms_available = current_run.area._get_rooms()

	current_run.available_powerups = PowerupDatabase.variant_to_props.keys()

	go_to_next_room()


func on_room_completed():
	assert(self.current_run)
	print("GameManager: on room completed.")

	current_run.completed_rooms += 1
	if (
		current_run.completed_rooms >= RunData.MAX_ROOMS_PER_RUN
		or current_run.rooms_available.size() == 0
	):
		complete_run()
	elif current_run.available_powerups.size() > 0:
		show_powerup_selection()
	else:
		go_to_next_room()


func show_powerup_selection():
	current_run.available_powerups.shuffle()
	var powerups_to_show = current_run.available_powerups.slice(0, current_run.max_powerup_select)
	var powerup_select = player.get_node("UI/PowerupSelect")
	powerup_select.show_cards(powerups_to_show)

	if not powerup_select.is_connected("powerup_selected", self, "on_powerup_selected"):
		powerup_select.connect("powerup_selected", self, "on_powerup_selected")


func on_powerup_selected(variant: int):
	current_run.available_powerups.erase(variant)
	player.get_node("PowerupManager").add_powerup(
		variant, PowerupDatabase.variant_to_props[variant]
	)
	go_to_next_room()


func go_to_next_room():
	assert(current_run)
	assert(current_run.area)
	var rooms = current_run.rooms_available
	var random_room_i = randi() % rooms.size()
	var room = rooms[random_room_i]
	current_run.rooms_available.erase(room)

	player.get_parent().remove_child(player)

	var err = get_tree().change_scene(room)
	if err != OK:
		push_error("Failed to change room.")


func complete_run():
	assert(self.current_run)
	print("GameManager: run completed.")
	go_to_hub()


func on_player_death():
	assert(self.current_run)
	print("GameManager: on_player_death.")
	go_to_hub()
