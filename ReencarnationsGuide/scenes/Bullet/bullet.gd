extends Area2D
class_name Bullet

@export var SPEED = 200
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var spawnPos: Vector2
var spawnRot: float
var go_left: bool = false

func bullet_buider(left:bool, rot:float, pos:Vector2):
	go_left = left
	spawnPos = pos
	spawnRot = rot

func _ready() -> void:
	global_position = spawnPos
	global_rotation = spawnRot
	if go_left:
		sprite.flip_h = true


func _physics_process(delta: float) -> void:
	if go_left:
		global_position.x -= SPEED*delta
	else:
		global_position.x += SPEED*delta


func destroy_self():
	self.queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	destroy_self()
