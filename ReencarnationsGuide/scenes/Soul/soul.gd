extends Area2D

func _on_body_entered(body):
	#print("Soul Collected")
	if body.soul_collected():
		queue_free()
