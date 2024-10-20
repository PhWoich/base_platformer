extends Node
class_name GameManager

signal game_over_sig

var timer_start_value:float = 60.0
var timer_cont:float = 0.0
var timer_int:int = 0

var soul_count: int = 0

@onready var player: CharacterBody2D = $Player

@onready var timer_view:Label = $"CanvasUI/Control/UI/Container General/Container Top/Timer View"
@onready var game_over_view: Label = $"CanvasUI/Control/GameOver_sendScore/Container General/Container Bottom/Game Over View"
@onready var soul_view: Label = $"CanvasUI/Control/UI/Container General/Container Top/Soul View"
@onready var PlayerName_line_edit = $"CanvasUI/Control/GameOver_sendScore/Container General/Container Center/HBoxContainer/VBoxContainer/LineEdit"
@onready var container_game_over_send_score = $CanvasUI/Control/GameOver_sendScore
@onready var container_game_over_leader_board = $CanvasUI/Control/GameOver_LeaderBoard
@onready var score_player_position = $CanvasUI/Control/GameOver_LeaderBoard/HBoxContainer2/HBoxContainer/Score_PlayerPosition
@onready var score_player_name = $CanvasUI/Control/GameOver_LeaderBoard/HBoxContainer2/HBoxContainer/Score_PlayerName
@onready var score_player_score = $CanvasUI/Control/GameOver_LeaderBoard/HBoxContainer2/HBoxContainer/Score_PlayerScore



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_over_view.text = ""
	timer_cont = timer_start_value
	timer_int = timer_start_value
	timer_view.text = str(timer_int)
	player.buid_player(self)
	game_over_sig.connect(player.game_over_reaction)
	soul_count = 0
	
	SilentWolf.configure({
		"api_key": "jqEGorvY4Na5v5qkNBiHb96XcbNS98Djhpkwhcha",
		"game_id": "ReencarnationsGuide",
		"log_level": 2})

	SilentWolf.configure_scores({"open_scene_on_close": "res://scenes/MainPage.tscn"})


# Called every frame. 'delta' is the elapsed time since the previous frame.
var game_over_registered : bool = false
func _process(delta: float) -> void:
	if !game_over():
		game_over_view.text = ""
		timer_cont = timer_cont-delta
		timer_int = timer_cont
		timer_view.text = str(timer_int)
		soul_view.text = str(soul_count)
	else:
		if !game_over_registered:
			game_over_registered = true
			container_game_over_send_score.visible = true
			game_over_view.text = "GAME OVER!\nPress R to restart the game."
			game_over_sig.emit()
			
			
	#if Input.is_action_just_released("restart_game") and game_over():
		#game_restart()
	#if Input.is_action_just_released("restore"):
		## Quando aperta 2 no teclado para testar
		#restore_all()

func damage(damage_taken: int) -> void:
	timer_cont = timer_cont-damage_taken
	timer_int = timer_int-damage_taken


func restore_all() -> void:
	timer_cont = timer_start_value
	timer_int = timer_start_value
	soul_count = 0


func game_over() -> bool:
	if timer_int <= 0 or soul_count >= 100: 
		return true
	else:
		return false

func game_restart() -> void:
	get_tree().reload_current_scene()

func add_soul():
	soul_count += 1






func _on_send_score_button_pressed():
	var actual_score = 10*soul_count + timer_cont
	actual_score = 100
	var scoreId
	if PlayerName_line_edit.text!='':
		var sw_result: Dictionary = await SilentWolf.Scores.save_score(PlayerName_line_edit.text, actual_score).sw_save_score_complete
		print("Request: " + str(PlayerName_line_edit.text) + "; " + str(actual_score))
		print("Response: " + str(sw_result))
		print("Score persisted successfully: " + str(sw_result.score_id))
		#var score_id = await SilentWolf.Scores.persist_score(PlayerName_line_edit.text, score).sw_score_posted
		scoreId=sw_result.score_id
	
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores(10).sw_get_scores_complete
	print("Scores: " + str(sw_result.scores))
	
	var idx=1
	score_player_position.text = ""
	score_player_name.text = ""
	score_player_score.text = ""
	for score in SilentWolf.Scores.scores:
		score_player_position.text+='#'+str(idx)+'\n'
		score_player_name.text+=score.player_name+'\n'
		score_player_score.text+=str(score.score)+'\n'
		idx+=1
	
	container_game_over_send_score.visible = false
	container_game_over_leader_board.visible = true




func _on_button_pressed():
	game_restart()
