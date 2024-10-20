extends State
class_name EnemyDamage

@export var animated_sprite: AnimatedSprite2D

func Enter():
	#print("Enter Idle")
	animated_sprite.play("damage")

func Exit():
	#print("Exit Idle")
	pass
	
func Update(delta: float):
	if !animated_sprite.is_playing():
		Transitioned.emit(self, "EnemyIdle")
