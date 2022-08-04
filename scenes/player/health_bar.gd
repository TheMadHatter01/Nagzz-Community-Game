extends ProgressBar


func _ready():
	max_value = HealthStats.max_health
	value = HealthStats.health
	var max_health_connect_err = HealthStats.connect(
		"max_health_changed", self, "set_max_health_bar"
	)
	if max_health_connect_err != OK:
		push_error("Failed to connect to max health changed signal.")
	var health_connect_err = HealthStats.connect("health_changed", self, "set_health_bar")
	if health_connect_err != OK:
		push_error("Failed to connect to health changed signal.")


func set_max_health_bar(value):
	self.max_value = value


func set_health_bar(value):
	self.value = value
