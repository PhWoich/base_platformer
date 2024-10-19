extends State
class_name PortalDeactivate

@export var animated_sprite: AnimatedSprite2D
	
var body_entered : bool = false

func Enter():
	print("Enter Deactivate")
	animated_sprite.play("disappear")
	body_entered = false
	
func Exit():
	print("Exit Deactivate")
	
func Update(delta: float):
	if !animated_sprite.is_playing():
		Transitioned.emit(self, "PortalWait")
	if body_entered:
		Transitioned.emit(self, "PortalIdle")
		body_entered = false

func Physics_Update(delta: float):
	pass

func _on_area_activation_body_entered(body):
	body_entered = true
