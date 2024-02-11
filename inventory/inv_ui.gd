extends Control

@onready var inv : Inv = preload("res://inventory/player_inventory.tres")
@onready var slots : Array = $NinePatchRect/GridContainer.get_children()

var is_open : bool = false

func _ready():
	inv.update.connect(update_slots)
	update_slots()
	close_inv()

func _process(delta):
	if Input.is_action_just_pressed("inv"):
		if is_open:
			close_inv()
		else:
			open_inv()

func open_inv():
	visible = true
	is_open = true

func close_inv():
	visible = false
	is_open = false

func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
