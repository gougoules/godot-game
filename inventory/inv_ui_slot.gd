extends Panel

@onready var item_visual : Sprite2D = $CenterContainer/Panel/item_display
@onready var amount_text : Label = $CenterContainer/Panel/Label

func _ready(): 
	amount_text.visible = false
	item_visual.visible = false

func update(slot : invSlot):
	if !item_visual:
		print("Error $> 84: Item visual not defined!")
		return 84
	if !slot.item:
		item_visual.visible = false
		amount_text.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		if slot.amount >= 2:
			amount_text.visible = true
			amount_text.text = str(slot.amount)
	return 0
