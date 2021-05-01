extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn")

func create_grassEffect():
	var grassEffect = GrassEffect.instance()
	var main = get_tree().current_scene
	get_parent().add_child(grassEffect)
	grassEffect.global_position = global_position

func _on_HurtBox_area_entered(_area):
	create_grassEffect()
	queue_free()
