extends Panel

################################################################################
# Attributes
################################################################################
signal IntLevelUp
signal StrLevelUp
signal ChrLevelUp
signal AprLevelUp
signal LckLevelUp
@onready var int_progress_bar = $MarginContainer/VBoxContainer/IntContainer/IntProgressBar
@onready var str_progress_bar = $MarginContainer/VBoxContainer/StrContainer/StrProgressBar
@onready var chr_progress_bar = $MarginContainer/VBoxContainer/ChrContainer/ChrProgressBar
@onready var apr_progress_bar = $MarginContainer/VBoxContainer/AprContainer/AprProgressBar
@onready var lck_progress_bar = $MarginContainer/VBoxContainer/LckContainer/LckProgressBar

const xpIncrement = 8.34
const maxValue = 100
const minValue = 0
################################################################################
# Custom Functions
################################################################################
func increaseInt():
	var newXPLevel = int_progress_bar.value + xpIncrement
	if (newXPLevel >= maxValue):
		IntLevelUp.emit()
		int_progress_bar.value = minValue
	else:
		int_progress_bar.value = newXPLevel
		
func increaseStr():
	var newXPLevel = str_progress_bar.value + xpIncrement
	if (newXPLevel >= maxValue):
		StrLevelUp.emit()
		str_progress_bar.value = minValue
	else:
		str_progress_bar.value = newXPLevel
		
func increaseChr():
	var newXPLevel = chr_progress_bar.value + xpIncrement
	if (newXPLevel >= maxValue):
		ChrLevelUp.emit()
		chr_progress_bar.value = minValue
	else:
		chr_progress_bar.value = newXPLevel	
		
func increaseApr():
	var newXPLevel = apr_progress_bar.value + xpIncrement
	if (newXPLevel >= maxValue):
		AprLevelUp.emit()
		apr_progress_bar.value = minValue
	else:
		apr_progress_bar.value = newXPLevel	
		
func increaseLck():
	var newXPLevel = lck_progress_bar.value + xpIncrement
	if (newXPLevel >= maxValue):
		LckLevelUp.emit()
		lck_progress_bar.value = minValue
	else:
		lck_progress_bar.value = newXPLevel	

################################################################################
# Signals
################################################################################
func _on_close_button_pressed():
	hide()
