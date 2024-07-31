extends Control

################################################################################
# Attributes
################################################################################
@onready var name_entry = $Panel/MarginContainer/VBoxContainer/UserInfo/NameEntry
@onready var gender_entry = $Panel/MarginContainer/VBoxContainer/UserInfo/GenderEntry
@onready var age_entry = $Panel/MarginContainer/VBoxContainer/UserInfo/AgeEntry
@onready var difficulty_entry = $Panel/MarginContainer/VBoxContainer/UserInfo/DifficultyEntry
@onready var warning_label = $Panel/MarginContainer2/VBoxContainer/WarningLabel
@onready var attributes_panel = $Panel/MarginContainer/VBoxContainer/AttributesPanel
@onready var attr_remaining_label = $Panel/MarginContainer/VBoxContainer/AttributesPanel/VBoxContainer/AttrRemainingContainer/AttrRemainingLabel
@onready var main_game_play = $MainGamePlay

var canStartNewLife = false 

var attributeFilledTexture = load("res://CreateLife/Assets/circleSolid.svg")
var attributeOutlineTexture = load("res://CreateLife/Assets/circleOutline.svg")
var femaleIcon = load("res://MainGamePlay/Assets/female.svg")
var maleIcon = load("res://MainGamePlay/Assets/male.svg")

const attributeMin = 0
const attributeMax = 0
var attributeCount : int
var attributeLimit : int
var attributes = {	"Strength": 0,
					"Intelligence": 0,
					"Charisma" : 0,
					"Luck" : 0,
					"Appearance" : 0 }
var attributeNodePathPrefix = "Panel/MarginContainer/VBoxContainer/AttributesPanel/VBoxContainer/GridContainer/"
enum GENDER {FEMALE = 0, MALE = 1}
enum AGE {NEWBORN = 0, CHILD = 1, TEEN = 2, ADULT =3}
enum DIFFICULTY {EASY = 0, NORMAL = 1, HARD = 2}
enum ATTRIBUTE{NEWBORN = 0, CHILD = 5, TEEN = 13, ADULT = 18}
const UNSELECTED = -1

signal menu_pressed
################################################################################
# Called when the node enters the scene tree for the first time.
################################################################################
func _ready():
	warning_label.hide()
	attributes_panel.hide()
	pass

################################################################################
# Called every frame. 'delta' is the elapsed time since the previous frame.
################################################################################
func _process(delta):
	if (allDataFieldsFilled() == true):
		canStartNewLife = true
	else:
		canStartNewLife = false
	
################################################################################
# Custom Functions
################################################################################
func allDataFieldsFilled():
	warning_label.text = ""
	var returnType = true
	if (name_entry.text.is_empty()):
		warning_label.text = "* Enter Name *\n"
		returnType = returnType and false
	if ( attributeCount > attributeMin):
		warning_label.text = warning_label.text + "* Assign Attributes *\n"
		returnType = returnType and false
	if ( gender_entry.get_selected_id() == UNSELECTED):
		warning_label.text = warning_label.text + "* Select Gender *\n"
		returnType = returnType and false
	if ( age_entry.get_selected_id() == UNSELECTED):
		warning_label.text = warning_label.text + "* Select Age *\n"
		returnType = returnType and false
	if ( difficulty_entry.get_selected_id() == UNSELECTED):
		warning_label.text = warning_label.text + "* Select Difficulty *"
		returnType = returnType and false
		
	if (returnType == true):
		warning_label.hide()
	return returnType
		
func resetLife():
	main_game_play.reset()
	resetAttributes()
	attributes_panel.hide()
	name_entry.text = ""
	gender_entry.select(UNSELECTED)
	age_entry.select(UNSELECTED)
	difficulty_entry.select(UNSELECTED)
		
func resetAttributes():
	var intPrefix = "Int"
	var chrPrefix = "Chr"
	var aprPrefix = "Apr"
	var strPrefix = "Str"
	var lckPrefix = "Lck"
	for attribute in attributes:
		attributes[attribute] = attributeMin
	for i in range(1,10):
		var intNodePath = attributeNodePathPrefix+intPrefix+"VBoxContainer/HBoxContainer/"+intPrefix+"Level"+str(i)
		var chrNodePath = attributeNodePathPrefix+chrPrefix+"VBoxContainer/HBoxContainer/"+chrPrefix+"Level"+str(i)
		var aprNodePath = attributeNodePathPrefix+aprPrefix+"VBoxContainer/HBoxContainer/"+aprPrefix+"Level"+str(i)
		var strNodePath = attributeNodePathPrefix+strPrefix+"VBoxContainer/HBoxContainer/"+strPrefix+"Level"+str(i)
		var lckNodePath = attributeNodePathPrefix+lckPrefix+"VBoxContainer/HBoxContainer/"+lckPrefix+"Level"+str(i)
		var intNode = get_node(intNodePath)
		var chrNode = get_node(chrNodePath)
		var aprNode = get_node(aprNodePath)
		var strNode = get_node(strNodePath)
		var lckNode = get_node(lckNodePath)
		intNode.texture = attributeOutlineTexture
		chrNode.texture = attributeOutlineTexture
		aprNode.texture = attributeOutlineTexture
		strNode.texture = attributeOutlineTexture
		lckNode.texture = attributeOutlineTexture	
	
func increaseLevel(attributeName,levelprefix):
	warning_label.hide()
	var currentAttributeLevel = attributes[attributeName]
	if (attributeCount > attributeMin):
		if (currentAttributeLevel < attributeMax):
			attributes[attributeName] += 1
			attributeCount -= 1
			attr_remaining_label.text = str(attributeCount)
			var nodePath = attributeNodePathPrefix+levelprefix+"VBoxContainer/HBoxContainer/"+levelprefix+"Level"+str(attributes[attributeName])
			var node = get_node(nodePath)
			node.texture = attributeFilledTexture

func decreaseLevel(attributeName,levelprefix):
	warning_label.hide()
	var currentAttributeLevel = attributes[attributeName]
	if (currentAttributeLevel > attributeMin):
		attributes[attributeName] -= 1
		attributeCount +=1
		if(attributeCount > attributeLimit):
			attributeCount = attributeLimit
		attr_remaining_label.text = str(attributeCount)
		var nodePath = attributeNodePathPrefix+levelprefix+"VBoxContainer/HBoxContainer/"+levelprefix+"Level"+str(currentAttributeLevel)
		var node = get_node(nodePath)
		node.texture = attributeOutlineTexture

################################################################################
# Signals
################################################################################

func _on_return_button_pressed():
	hide()

func _on_start_button_pressed():
	if( canStartNewLife == true):
		SaveLoad.deleteSave()
		main_game_play.intelligence_label.text = str(attributes["Intelligence"])
		main_game_play.charisma_label.text = str(attributes["Charisma"])
		main_game_play.strength_label.text = str(attributes["Strength"])
		main_game_play.appearance_label.text = str(attributes["Appearance"])
		main_game_play.luck_label.text = str(attributes["Luck"])
		main_game_play.saveGame()
		main_game_play.show()
	else:
		warning_label.show()

func _on_name_entry_text_changed(new_text):
	main_game_play.player_name.text = new_text
	warning_label.hide()

func _on_gender_entry_item_selected(index):
	main_game_play.setGender(index)
	warning_label.hide()
	
func _on_age_entry_item_selected(index):
	warning_label.hide()
	resetAttributes()
	if( index == AGE.NEWBORN):
		attributes_panel.hide()
		attributeCount = ATTRIBUTE.NEWBORN
		attributeLimit = ATTRIBUTE.NEWBORN 
		attr_remaining_label.text = str(ATTRIBUTE.NEWBORN)
		main_game_play.setAge(ATTRIBUTE.NEWBORN)
	elif(index == AGE.CHILD):
		attributeCount = ATTRIBUTE.CHILD
		attributeLimit = ATTRIBUTE.CHILD
		attr_remaining_label.text = str(ATTRIBUTE.CHILD)
		main_game_play.setAge(ATTRIBUTE.CHILD)
		attributes_panel.show()
	elif(index == AGE.TEEN):
		attributeCount = ATTRIBUTE.TEEN
		attributeLimit = ATTRIBUTE.TEEN
		attr_remaining_label.text = str(ATTRIBUTE.TEEN)
		main_game_play.setAge(ATTRIBUTE.TEEN)
		attributes_panel.show()
	elif(index == AGE.ADULT):
		attributeCount = ATTRIBUTE.ADULT
		attributeLimit = ATTRIBUTE.ADULT 
		attr_remaining_label.text = str(ATTRIBUTE.ADULT)
		main_game_play.setAge(ATTRIBUTE.ADULT)
		attributes_panel.show()

func _on_difficulty_entry_item_selected(index):
	if( index == DIFFICULTY.EASY): #Easy
		main_game_play.money.setBalance(10000)
	elif(index == DIFFICULTY.NORMAL): #Normal
		main_game_play.money.setBalance(1000)
	elif(index == DIFFICULTY.HARD): #Hard
		main_game_play.money.setBalance(100)
	warning_label.hide()
	
func _on_int_inc_button_pressed():
	increaseLevel("Intelligence","Int")

func _on_int_dec_button_pressed():
	decreaseLevel("Intelligence","Int")

func _on_str_dec_button_pressed():
	decreaseLevel("Strength","Str")

func _on_str_inc_button_pressed():
	increaseLevel("Strength","Str")

func _on_chr_dec_button_pressed():
	decreaseLevel("Charisma","Chr")
	
func _on_chr_inc_button_pressed():
	increaseLevel("Charisma","Chr")

func _on_apr_dec_button_pressed():
	decreaseLevel("Appearance","Apr")

func _on_apr_inc_button_pressed():
	increaseLevel("Appearance","Apr")

func _on_lck_dec_button_pressed():
	decreaseLevel("Luck","Lck")

func _on_lck_inc_button_pressed():
	increaseLevel("Luck","Lck")

func _on_main_game_play_menu_pressed():
	main_game_play.hide()
	hide()
	menu_pressed.emit()
