extends Node

export var max_health = 1 setget set_max_health

var health = max_health setget setHealth

signal health_changed(value)
signal max_health_changed(value)
signal no_health

func set_max_health(value):
	max_health = value
	emit_signal("max_health_changed", value)

func setHealth(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0: emit_signal("no_health")

func _ready():
	self.health = max_health
