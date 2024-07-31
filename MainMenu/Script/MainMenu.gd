extends Control
@onready var create_life = $CreateLife
@onready var continue_life_button = $Panel/MarginContainer/VBoxContainer/ContinueLifeButton
@onready var load_error_label = $Panel/AboutContainer/VBoxContainer/LoadErrorLabel

func _ready():
	if( SaveLoad.saveFileExist()):
		continue_life_button.show()
	else:
		continue_life_button.hide()

################################################################################
# Signals
################################################################################

func _on_continue_life_button_pressed():
	if( create_life.main_game_play.loadGame() ):
		create_life.main_game_play.show()
		create_life.show()
	else:
		# Add window that shows an error occured
		load_error_label.show()
		pass

func _on_create_life_button_pressed():
	load_error_label.hide()
	create_life.resetLife()
	create_life.show()

func _on_create_life_menu_pressed():
	continue_life_button.show()
	
