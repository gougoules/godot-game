extends Node2D

@export var life : int
var collectables : bool = false

func drop(collectable, pos : Vector2) -> void:
	queue_free()
	var collectable_instance = collectable.instantiate()
	collectable_instance.global_position = pos
	get_parent().add_child(collectable_instance)

func get_collectable() -> bool:
	return collectables
