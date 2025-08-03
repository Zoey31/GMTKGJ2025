extends Control
@export_category("Required")
@export var player: PlayerController
var score = 0

func _ready():
	if player:
		player.score_screen.connect(showWindow)
		player.pickup_item.connect(add_score)
	var restart_button = $HBoxContainer/VBoxContainer/Panel/VBoxContainer/HBoxContainer/Restart
	restart_button.connect("button_down", restartGame)
	
	var close_button = $HBoxContainer/VBoxContainer/Panel/VBoxContainer/HBoxContainer/EndGame
	close_button.connect("button_down", closeGame)
	
func add_score(pickup: PickupStats):
	score += pickup.points
		
func get_congratulation_text(score):
	if score >= 16000:
		return "INCREDIBLE!"
	elif score >= 8000:
		return "WOW!"
	elif score >= 4000:
		return "Great job!"
	elif score >= 2000:
		return "Good job!"
	elif score >= 1000:
		return "Nice job!"

	return ""
		
func showWindow():
	$HBoxContainer/VBoxContainer/Panel/VBoxContainer/Score.text = str(score) + " points"
	
	$HBoxContainer/VBoxContainer/Panel/VBoxContainer/Message2.text = get_congratulation_text(score)
	visible = true
	
func hideWindow():
	visible = false

func restartGame():
	get_tree().reload_current_scene()
	
func closeGame():
	get_tree().quit()
