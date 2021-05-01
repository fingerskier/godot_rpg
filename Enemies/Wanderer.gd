extends Node2D

export(int) var Range = 32
export(int) var Duration = 1

onready var start_position = global_position
onready var target_position = global_position
onready var timer = $Timer

func _ready():
	timer.wait_time = Duration

func update_target_position():
	var target_vector = Vector2(rand_range(-Range, Range), rand_range(-Range, Range))
	target_position = start_position + target_vector

func get_time_left():
	return timer.time_left

func set_timer(duration):
	Duration = duration
	timer.start(duration)

func _on_Timer_timeout():
	update_target_position()
