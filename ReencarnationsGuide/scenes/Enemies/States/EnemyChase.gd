extends State
class_name EnemyChase

@export var animated_sprite: AnimatedSprite2D
@export var enemy: CharacterBody2D
@export var move_speed := 40.0
@export var voador : bool = false

var body_inside : bool = true
var attack : bool = false

var floor : bool = true
	
func Enter():
	enemy.velocity.x = sign(enemy.velocity.x)*move_speed
	#body_inside = true
	attack = false
	animated_sprite.play("run")

func Exit():
	#enemy.scale.x = 1.0
	#enemy.velocity.x = move_toward(enemy.velocity.x, 0, move_speed)
	#enemy.move_and_slide()
	#print("Exit Wander")
	pass
	
func Update(delta: float):
	if !body_inside:
		Transitioned.emit(self, "EnemySwitch")
		#body_inside = true
	elif attack:
		Transitioned.emit(self, "EnemyAttack")
		attack = false

func Physics_Update(delta: float):
	if enemy:
		if floor: 
			if !enemy.is_on_wall():
				enemy.move_and_slide()

func _on_area_chase_body_entered(body):
	body_inside = true
	
func _on_area_chase_body_exited(body):
	body_inside = false

func _on_area_ground_body_entered(body):
	#print("found Floor")
	floor = true

func _on_area_ground_body_exited(body):
	#print("lost Floor")
	floor = false or voador

func _on_area_attack_body_entered(body):
	attack = true

func _on_area_attack_body_exited(body):
	attack = false
