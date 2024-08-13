extends Control

@onready var player = $Player
@onready var left_button = $MarginContainer2/HBoxContainer/LeftButton
@onready var right_button = $MarginContainer2/HBoxContainer/RightButton
@onready var win_label = $MarginContainer3/WinLabel

signal playground_mini_game_won

const defaultPlayerPosition = Vector2(7, 971.4982)
# Called when the node enters the scene tree for the first time.
func _ready():
	resetPlayer()
	win_label.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func resetPlayer():
	win_label.hide()
	player.position = defaultPlayerPosition

func _on_return_button_pressed():
	resetPlayer()
	hide()

func _on_left_button_pressed():
	right_button.disabled = false
	left_button.disabled = true
	player.leftPressed()

func _on_right_button_pressed():
	right_button.disabled = true
	left_button.disabled = false
	player.rightPressed()

func _on_finish_line_body_entered(body):
	if(player.position == defaultPlayerPosition):
		win_label.hide()
	else:
		resetPlayer()
		win_label.show()
		playground_mini_game_won.emit()
	player.stopPlayer()
	
	
