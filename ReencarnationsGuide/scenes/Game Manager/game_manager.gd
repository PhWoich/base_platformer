extends Node

signal game_over_sig

var timer_start_value:float = 60.0
var timer_cont:float = 0.0
var timer_int:int = 0

@onready var player: CharacterBody2D = $Player

@onready var timer_view:Label = $"CanvasUI/Control/MarginContainer/Container General/Container Top/Timer View"
@onready var game_over_view: Label = $"CanvasUI/Control/MarginContainer/Container General/Container Center/Game Over View"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_over_view.text = ""
	timer_cont = timer_start_value
	timer_int = timer_start_value
	timer_view.text = str(timer_int)
	player.buid_player(self)
	game_over_sig.connect(player.game_over_reaction)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !game_over():
		game_over_view.text = ""
		timer_cont = timer_cont-delta
		timer_int = timer_cont
		timer_view.text = str(timer_int)
	
	if Input.is_action_just_released("restart_game") and game_over():
		game_restart()
	elif Input.is_action_just_released("damage"):
		# Quando aperta 1 no teclado para testar
		damage(10)
	elif Input.is_action_just_released("restore"):
		# Quando aperta 2 no teclado para testar
		restore_all()

func damage(damage_taken: int) -> void:
	timer_cont = timer_cont-damage_taken
	timer_int = timer_int-damage_taken


func restore_all() -> void:
	timer_cont = timer_start_value
	timer_int = timer_start_value


func game_over() -> bool:
	if timer_int <= 0:
		game_over_view.text = "GAME OVER!\nPress R to restart the game."
		game_over_sig.emit()
		return true
	else:
		return false

func game_restart() -> void:
	get_tree().reload_current_scene()
