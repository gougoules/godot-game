extends Node2D

@export var item : InvItem

func _on_collectable_area_body_entered(body) -> void:
	if body.name == "player":
		var err : int = body.collect(item)
		if err == 0:
			queue_free()
