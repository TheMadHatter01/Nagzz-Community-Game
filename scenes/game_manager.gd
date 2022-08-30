extends Node

const PLAYER_NODE := preload("res://scenes/player/player.tscn")

const AREAS := {"test_area": preload("res://scenes/areas/test_area/test_area.gd")}

var player: Player = null
var current_run: RunData = null


# TODO extract to a file.
class RunData:
	const MAX_ROOMS_PER_RUN := 5

	var area = null
	var rooms_available = []
	var completed_rooms = 0


func _ready() -> void:
	pass


func save_game():
	# TODO
	pass


func load_game():
	# TODO
	pass


func spawn_player(position: Position2D):
	self.player = PLAYER_NODE.instance()
	self.player.position = position.position
	position.get_parent().add_child(self.player)
	self.player.call_deferred("set_owner", position.get_tree().root)


func go_to_hub():
	var err = get_tree().change_scene("res://scenes/hub/hub.tscn")
	if err != OK:
		push_error("Failed to change scene to hub.")


func enter_area(area_name: String):
	self.current_run = RunData.new()
	print("Enter area:", area_name)
	assert(area_name in AREAS)
	current_run.area = AREAS[area_name].new() as BaseArea
	assert(current_run.area)
	self.current_run.rooms_available = current_run.area._get_rooms()
	go_to_next_room()


func on_room_completed():
	assert(self.current_run)
	print("GameManager: on room completed.")

	self.current_run.completed_rooms += 1
	if (
		self.current_run.completed_rooms >= RunData.MAX_ROOMS_PER_RUN
		or self.current_run.rooms_available.size() == 0
	):
		self.complete_run()
	else:
		self.go_to_next_room()


func go_to_next_room():
	assert(self.current_run)
	assert(self.current_run.area)
	var rooms = self.current_run.rooms_available
	var random_room_i = randi() % rooms.size()
	var room = rooms[random_room_i]
	self.current_run.rooms_available.erase(room)
	var err = get_tree().change_scene(room)
	if err != OK:
		push_error("Failed to change room.")


func complete_run():
	assert(self.current_run)
	print("GameManager: run completed.")
	self.go_to_hub()


func on_player_death():
	assert(self.current_run)
	print("GameManager: on_player_death.")
	self.go_to_hub()
