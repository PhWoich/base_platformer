extends State
class_name PortalActivate

@export var animated_sprite: AnimatedSprite2D
	
var body_exited : bool = false

func Enter():
	#print("Enter Activate")
	animated_sprite.play("emerge")
	body_exited = false
	
func Exit():
	#print("Exit Activate")
	pass
	
func Update(delta: float):
	if !animated_sprite.is_playing():
		Transitioned.emit(self, "PortalIdle")
	if body_exited:
		Transitioned.emit(self, "PortalWait")
		body_exited = false

func Physics_Update(delta: float):
	pass

func _on_area_activation_body_exited(body):
	body_exited = true
