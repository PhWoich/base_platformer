extends State
class_name EnemyAttack

@export var animated_sprite: AnimatedSprite2D
@export var enemy : Node2D

var player : Player

func _ready():
	pass
		
func Enter():
	player = get_node("/root/Game/Player")
	animated_sprite.play("attack")

func Exit():
	#print("Exit Idle")
	pass
	
func Update(delta: float):
	if !animated_sprite.is_playing():
		Transitioned.emit(self, "EnemySwitch")
		player.get_damage(enemy)

func Physics_Update(delta: float):
	pass
