extends State
class_name EnemyIdle

@export var animated_sprite: AnimatedSprite2D
@onready var timer = $Timer
@export var pivot : Node2D
@export var enemy: CharacterBody2D

var body_inside : bool = false
var chase_back : bool = false

func Enter():
	chase_back = false
	body_inside = false
	#print("Enter Idle")
	animated_sprite.play("idle")

func Exit():
	#print("Exit Idle")
	pass
	
func Update(delta: float):
	if body_inside:
		Transitioned.emit(self, "EnemyChase")
		body_inside = false
	elif !animated_sprite.is_playing():
		Transitioned.emit(self, "EnemySwitch")

func Physics_Update(delta: float):
	if chase_back:
		chase_back = false
		pivot.scale.x *= -1.0
		enemy.velocity.x = 0
		enemy.move_and_slide()

func _on_area_chase_body_entered(body):
	body_inside = true


func _on_area_chase_back_body_entered(body):
	chase_back = true
