extends Node2D
class_name SoundManager


@onready var explosion : AudioStreamPlayer2D = $Explosion
@onready var alma_pickup : AudioStreamPlayer2D = $Alma_pickup
@onready var alma_deliver : AudioStreamPlayer2D = $Alma_deliver
@onready var jump : AudioStreamPlayer2D = $Jump
@onready var hurt_enemy : AudioStreamPlayer2D = $Hurt_enemy
@onready var hurt_player : AudioStreamPlayer2D = $Hurt_player
@onready var portal_loop : AudioStreamPlayer2D = $portal_loop
@onready var shoot : AudioStreamPlayer2D = $shoot


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
