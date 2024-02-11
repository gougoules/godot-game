extends "res://scripts/components/materials.gd"
var stone = preload("res://components/collectable/stone_collectable.tscn")

func _ready() :
	life = 3

func gather(damage : int) :
	if (life == null) :
		print("Error $> 'life' is not defined")
		return
	life -= damage
	$sprite.play("stone_break")
	await $sprite.animation_finished
	if (life <= 0) :
		drop(stone, $Marker2D.get_global_position())
