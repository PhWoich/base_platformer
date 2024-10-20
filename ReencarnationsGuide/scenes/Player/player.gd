extends CharacterBody2D
class_name Player

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@export var gameManager : GameManager

@export var damage_jump : float = 30.0

@onready var root:Node2D
@onready var bullet = load("res://scenes/Bullet/bullet.tscn")

@onready var soul_carry = $soulCarry
@onready var bullet_point_right: Node2D = $Bullet_point_right
@onready var bullet_point_left: Node2D = $Bullet_point_left

@onready var animated_sprite_2d = $AnimatedSprite2D

var looking_left:bool
var last_bullet_point: Node2D
var damaged_dir:int = 0
var attacking : bool = false

func soul_collected():
	if not soul_carry.visible:
		soul_carry.visible = true
		return true
	return false

func soul_deliver():
	if soul_carry.visible:
		soul_carry.visible = false
		gameManager.add_soul()
		Music.alma_deliver.play()
		return true
	return false

func get_damage(from : Node2D):
	var distance = position.distance_to(from.position)
	if distance < 30: 
		Music.hurt_player.play()
		attacking = false
		attack_anim_running = false
		if from.position.x > position.x:
			damaged_dir = -1
		else:
			damaged_dir = 1 
	#root.damage(10)

func buid_player(root_node:Node2D):
	root = root_node
	last_bullet_point = bullet_point_right

func create_bullet():
	var bullet_instance = bullet.instantiate()
	bullet_instance.bullet_buider(looking_left, last_bullet_point.rotation, last_bullet_point.global_position)
	root.add_child(bullet_instance)
	attacking = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		Music.jump.play()
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_released("fire"):
		attacking = true
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
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
	
	if damaged_dir != 0:
		velocity.x = damaged_dir * damage_jump
		
	handle_animation(direction)
	move_and_slide()


func game_over_reaction():
	self.queue_free()


var taking_damage : bool = false
var attack_anim_running : bool = false
func handle_animation(direction):
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	if damaged_dir == 0:
		if !attacking:
			if is_on_floor():
				if direction == 0:
					animated_sprite_2d.play("idle")
				else:
					animated_sprite_2d.play("run")
			else:
				if velocity.y > 0:
					animated_sprite_2d.play("jump_start")
				else:
					animated_sprite_2d.play("jump_finish")
		else:
			if !attack_anim_running:
				animated_sprite_2d.play("atack_sp")
				Music.shoot.play()
				attack_anim_running = true
			else:
				if !animated_sprite_2d.is_playing():
					create_bullet()
					attack_anim_running = false
	else:
		if !taking_damage:
			animated_sprite_2d.play("damage")
			taking_damage = true
		else:
			if !animated_sprite_2d.is_playing():
				damaged_dir = 0
				taking_damage = false
