extends Area2D

var areas = null

func is_colliding():
	areas = get_overlapping_areas()
	return areas.size() > 0

func get_push_vector():
	areas = get_overlapping_areas()
	var push_vector = Vector2.ZERO
	if is_colliding():
		var area = areas[0]
		push_vector = area.global_position.direction_to(global_position)
#		push_vector = push_vector.normalized()
	return push_vector
