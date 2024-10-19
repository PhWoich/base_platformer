extends State
class_name PortalIdle

@export var animated_sprite: AnimatedSprite2D

var body_inside : bool = false

func Enter():
	#print("Enter Idle")
	animated_sprite.play("idle")

func Exit():
	#print("Exit Idle")
	pass
	
func Update(delta: float):
	if !body_inside:
		Transitioned.emit(self, "PortalDeactivate")
		body_inside = true

func Physics_Update(delta: float):
	pass


func _on_area_activation_body_exited(body):
	body_inside = false
	
func _on_area_activation_body_entered(body):
	body_inside = true

func _on_area_get_soul_body_entered(body : Player):
	body.soul_deliver()
