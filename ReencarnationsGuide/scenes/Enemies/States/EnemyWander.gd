extends State
class_name EnemyWander

@export var animated_sprite: AnimatedSprite2D
@export var enemy: CharacterBody2D
@export var pivot : Node2D
@export var move_speed := 20.0
@export var voador : bool = false

var wander_time : float
var body_inside : bool = false
var chase_back : bool = false
var move_direction : int = 1

var floor : bool = true

func randomize_wander():
	move_direction = randi_range(0,1)
	if move_direction == 0:
		move_direction = -1
		pivot.scale.x = -1.0
	else:
		pivot.scale.x = 1.0
	wander_time = randf_range(1,3)
	#wander_time = 60	
	
func Enter():
	body_inside = false
	chase_back = false
	randomize_wander()
	animated_sprite.play("run")

func Exit():
	#enemy.scale.x = 1.0
	#enemy.velocity.x = move_toward(enemy.velocity.x, 0, move_speed)
	#enemy.move_and_slide()
	#print("Exit Wander")
	pass
	
func Update(delta: float):
	if body_inside:
		Transitioned.emit(self, "EnemyChase")
		body_inside = false
	else:	
		if wander_time > 0:
			wander_time -= delta
		else: 
			Transitioned.emit(self, "EnemySwitch")

func Physics_Update(delta: float):
	if enemy:
		if chase_back:
			chase_back = false
			pivot.scale.x *= -1.0
			move_direction *= -1
		elif floor: 
			if enemy.is_on_wall():
				#print("Turn Wall")
				pivot.scale.x *= -1.0
				move_direction *= -1
		else:
			#Transitioned.emit(self, "EnemyIdle")
			#print("Turn Floor")
			pivot.scale.x *= -1.0
			move_direction *= -1
			floor = true
		enemy.velocity.x = move_speed * move_direction
		enemy.move_and_slide()
		
func _on_area_chase_body_entered(body):
	body_inside = true
	
func _on_area_ground_body_entered(body):
	#print("found Floor")
	floor = true

func _on_area_ground_body_exited(body):
	#print("lost Floor")
	floor = false or voador



func _on_area_chase_back_body_entered(body):
	chase_back = true
