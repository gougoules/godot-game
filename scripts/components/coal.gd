extends "res://scripts/components/materials.gd"
var coal = preload("res://components/collectable/coal_collectable.tscn")

func _ready() :
	life = 5

func gather(damage : int) :
	if (life == null) :
		print("Error $> 'life' is not defined")
		return
	life -= damage
	$sprite.play("coal_break")
	await $sprite.animation_finished
	if (life <= 0) :
		drop(coal, $Marker2D.get_global_position())
