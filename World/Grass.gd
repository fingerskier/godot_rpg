extends Node2D


func create_grassEffect():
	var GrassEffect = load("res://Effects/GrassEffect.tscn")
	var grassEffect = GrassEffect.instance()
	var main = get_tree().current_scene
	main.add_child(grassEffect)
	grassEffect.global_position = global_position

func _on_HurtBox_area_entered(area):
	create_grassEffect()
	queue_free()
