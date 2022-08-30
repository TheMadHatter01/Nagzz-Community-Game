extends Position2D


func _ready() -> void:
	GameManager.call_deferred("spawn_player", self)
