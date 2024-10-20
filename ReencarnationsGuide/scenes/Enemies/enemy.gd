extends CharacterBody2D

@onready var fsm = $FSM


func _on_area_collide_area_entered(area):
	fsm.on_child_transition(fsm.current_state, "EnemyDamage")
	area.queue_free()
