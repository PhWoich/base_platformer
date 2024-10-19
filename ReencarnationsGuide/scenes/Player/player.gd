extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var root:Node2D
@onready var bullet = load("res://scenes/Bullet/bullet.tscn")

@onready var soul_carry = $soulCarry
@onready var bullet_point_right: Node2D = $Bullet_point_right
@onready var bullet_point_left: Node2D = $Bullet_point_left

var looking_left:bool
var last_bullet_point: Node2D


func soul_collected():
	if not soul_carry.visible:
		soul_carry.visible = true
		return true
	return false


func buid_player(root_node:Node2D):
	root = root_node
	last_bullet_point = bullet_point_right


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_released("fire"):
		var bullet_instance = bullet.instantiate()
		bullet_instance.bullet_buider(looking_left, last_bullet_point.rotation, last_bullet_point.global_position)
		root.add_child(bullet_instance)
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction != 0.0:
		looking_left = direction < 0.0
	
	if looking_left:
		last_bullet_point = bullet_point_left
	else:
		last_bullet_point = bullet_point_right
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
