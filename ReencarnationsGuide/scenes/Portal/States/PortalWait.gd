extends State
class_name PortalWait

@export var animated_sprite: AnimatedSprite2D
	
var body_entered : bool = false

func Enter():
	print("Enter Wait")
	animated_sprite.visible = false
	body_entered = false
	
func Exit():
	print("Exit Wait")
	animated_sprite.visible = true
	
func Update(delta: float):
	if body_entered:
		Transitioned.emit(self, "PortalActivate")
		body_entered = false

func Physics_Update(delta: float):
	pass

func _on_area_activation_body_entered(body): #AreaActivation
	body_entered = true
