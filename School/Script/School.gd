extends Control

################################################################################
# Attributes
################################################################################
@onready var education_label = $Panel/MarginContainer/HBoxContainer/EducationLabel
@onready var friend_panel = $Panel/FriendPanel
@onready var friend_list = $Panel/FriendPanel/MarginContainer2/FriendList
@onready var ask_to_be_friend = $Panel/FriendPanel/MarginContainer/HBoxContainer/AskToBeFriend
@onready var response_label = $Panel/MarginContainer2/TabContainer/Preschool/MarginContainer/ResponseLabel
@onready var timer = $Timer

var attributes = {}

signal school_event(eventText)
signal happy_event(delta)

var maleIcon = load("res://MainGamePlay/Assets/male.svg")
var femaleIcon = load("res://MainGamePlay/Assets/female.svg")
var educationLevelArray = [	"N/A",				#0-2
							"Preschool",		#2-5
							"Elementary",		#5-10
							"Middle School",	#11-13
							"High School",		#14-18
							"UnderGraduate"]	#18+

const newBornAge = 0
const preschoolStartAge = 2
const elemStartAge = 5
const midStartAge = 11
const highStartAge = 14
const underGradStartAge = 18
var nameList = {}
################################################################################
# Called when the node enters the scene tree for the first time.
################################################################################
func _ready():
	pass
	

################################################################################
# Called every frame. 'delta' is the elapsed time since the previous frame.
################################################################################
func _process(delta):
	pass

################################################################################
# Custom Functions
################################################################################
func saveGame():
	var schoolDict = {}
	schoolDict["NameList"] = nameList
	return schoolDict
	
func loadGame(dataToBeLoaded):
	nameList = dataToBeLoaded["NameList"]
	for i in nameList:
		if (nameList[i] == "Male"):
			friend_list.add_item(i,maleIcon)
		elif(nameList[i] == "Female"):
			friend_list.add_item(i,femaleIcon)

func generateNameList():
	nameList.clear()
	friend_list.clear()
	nameList = NameGenerator.getListOfNames(10)
	for i in nameList:
		if (nameList[i] == "Male"):
			friend_list.add_item(i,maleIcon)
		elif(nameList[i] == "Female"):
			friend_list.add_item(i,femaleIcon)
				
func setAttributes(newAttributes):
	attributes = newAttributes

func setSchool(age):
	if ( age >= newBornAge && age < preschoolStartAge): #0-2
		education_label.text = educationLevelArray[0]
	elif( age >= preschoolStartAge && age < elemStartAge): #2-4
		education_label.text = educationLevelArray[1]
	elif( age >= elemStartAge && age < midStartAge): #5-10
		education_label.text = educationLevelArray[2]	
	elif( age >= midStartAge && age < highStartAge): #11-13
		education_label.text = educationLevelArray[3]
	elif( age >= highStartAge && age < underGradStartAge): #14-18
		education_label.text = educationLevelArray[4]
	else:
		education_label.text = educationLevelArray[0]
			
################################################################################
# Signals
func _on_return_button_pressed():
	hide()

func _on_make_friends_pressed():
	friend_panel.show()

func _on_playground_pressed():
	pass

func _on_close_friend_panel_pressed():
	friend_panel.hide()

func _on_friend_list_item_selected(index):
	ask_to_be_friend.show()

func _on_ask_to_be_friend_pressed():
	var itemSelected = friend_list.get_selected_items()
	var nameSelected = friend_list.get_item_text(itemSelected[0])	
	friend_list.remove_item(itemSelected[0])
	nameList.erase(nameSelected)
	var eventText = "\nAsked "+nameSelected+" to be friend."
	var charisma = int(attributes["Charisma"])
	var appearance = int(attributes["Appearance"])
	if (charisma > 3 or appearance > 3):
		eventText = eventText + "\n"+nameSelected+" said yes!"
		response_label.text = nameSelected+ " said yes!"
		happy_event.emit(5)
	else:
		var rng = RandomNumberGenerator.new()
		var pick = rng.randi_range(0,1)
		var yes = 1
		if( pick == 1):
			eventText = eventText + "\n"+nameSelected+" said yes!"
			response_label.text = nameSelected+ " said yes!"
			happy_event.emit(5)
		else:
			eventText = eventText + "\n"+nameSelected+" said no!"
			response_label.text = nameSelected+ "said no!"
			happy_event.emit(-5)
	
	school_event.emit(eventText) #Adds text to main game
	friend_panel.hide()
	response_label.show()
	timer.start()
	
func _on_timer_timeout():
	response_label.hide()
