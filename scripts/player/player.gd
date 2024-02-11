extends CharacterBody2D

@export var speed : float = 1
@export var inv : Inv
var raycast : RayCast2D
var pickaxe_force : int = 1 # A changer quand j'aurais les pioches
var force : int = 1 # A changer quand j'aurais une fonctionnalité (???)
var damage : int = pickaxe_force * force

func _ready() :
	raycast = $interaction_area/RayCast2D

func _process(_delta) -> void :
	velocity = Vector2.ZERO

	if (Input.is_action_pressed("move_right")) :
		velocity.x = 1
	if (Input.is_action_pressed("move_left")) :
		velocity.x = -1
	if (Input.is_action_pressed("move_down")) :
		velocity.y = 1
	if (Input.is_action_pressed("move_up")) :
		velocity.y = -1

	if (velocity.length() > 0) :
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play("walk")
	else :
		$AnimatedSprite.play("idle")
	if (velocity.x != 0) :
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_h = velocity.x < 0

	move_and_collide(velocity * speed, false, 0.08, false)

func collect(item : InvItem) -> int :
	var err : int = inv.insert(item)

	if (err == 84) :
		return err
	return 0

func check_if_area(object) -> bool :
	if (object.get_parent().has_method("get_collectable") && object.get_parent().get_collectable()) :
		return true
	return false

func gather_res() -> int :
	var obj : Object
	var cursorPosition : Vector2 = get_global_mouse_position()

	cursorPosition.x -= position.x
	cursorPosition.y -= position.y
	raycast.target_position = cursorPosition
	raycast.force_update_transform()
	raycast.force_raycast_update()
	if (raycast.is_colliding()) :
		obj = raycast.get_collider()
	if (obj != null && check_if_area(obj)) :
		obj.get_parent().gather(damage)
	return 0

func _input(event) -> void :
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT :
		gather_res()

func _on_interaction_area_body_entered(body) :
	if (body.get_parent().has_method("get_collectable")) :
		body.get_parent().collectables = true
	if (body.has_meta("get_collectable")) :
		body.get_parent().collectables = true

func _on_interaction_area_body_exited(body):
	if (body.get_parent().has_method("get_collectable")) :
		body.get_parent().collectables = false
