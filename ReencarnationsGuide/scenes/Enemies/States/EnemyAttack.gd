extends State
class_name EnemyAttack

@export var animated_sprite: AnimatedSprite2D
@export var enemy : Node2D

var player : Player

func _ready():
	pass
		
func Enter():
	animated_sprite.play("attack")

func Exit():
	#print("Exit Idle")
	pass
	
func Update(delta: float):
	if !animated_sprite.is_playing():
		Music.explosion.play()
		Transitioned.emit(self, "EnemySwitch")
		
		player = get_node("/root/Game/Player")
		if player != null:
			player.get_damage(enemy)
		#else:
			#print("bug prevented")

func Physics_Update(delta: float):
	pass
