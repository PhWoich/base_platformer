extends State
class_name EnemySwitch

var selected : bool = false
var selection : int = 0

func Enter():
	selection = randi_range(0,1)
	selected = false

func Exit():
	#print("Exit Idle")
	pass
	
func Update(delta: float):
	if !selected:
		selected = true
		if selection == 0:
			Transitioned.emit(self, "EnemyIdle")
		else:
			Transitioned.emit(self, "EnemyWander")

func Physics_Update(delta: float):
	pass
