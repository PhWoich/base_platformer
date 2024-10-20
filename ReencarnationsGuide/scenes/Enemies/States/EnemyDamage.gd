extends State
class_name EnemyDamage

@export var animated_sprite: AnimatedSprite2D
@export var root_node_enemy : CharacterBody2D

func Enter():
	#print("Enter Idle")
	Music.hurt_enemy.play()
	animated_sprite.play("damage")
	root_node_enemy.set_collision_layer_value(1, false)

func Exit():
	root_node_enemy.set_collision_layer_value(1, true)
	
func Update(delta: float):
	if !animated_sprite.is_playing():
		Transitioned.emit(self, "EnemyIdle")
