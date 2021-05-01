extends Node

export var max_health = 1

onready var health = max_health setget setHealth

signal no_health

func setHealth(value):
	health = value
	if health <= 0: emit_signal("no_health")
