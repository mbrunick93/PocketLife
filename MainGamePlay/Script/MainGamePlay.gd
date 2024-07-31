extends Control

################################################################################
# Attributes
################################################################################

@onready var life_events_text = $Background/LifeEventsContainer/VBoxContainer/LifeEventsText
@onready var player_gender = $Background/LifeEventsContainer/VBoxContainer/GenderNameContainer/PlayerGender
@onready var player_name = $Background/LifeEventsContainer/VBoxContainer/GenderNameContainer/PlayerName
@onready var age_label = $Background/LifeEventsContainer/VBoxContainer/AgeContainer/AgeLabel
@onready var health_progress_bar = $Background/LifeEventsContainer/VBoxContainer/StatsPanel/StatsContainer/HealthProgressBar
@onready var happy_progress_bar = $Background/LifeEventsContainer/VBoxContainer/StatsPanel/StatsContainer/HappyProgressBar
@onready var intelligence_label = $Background/LifeEventsContainer/VBoxContainer/StatsPanel/StatsContainer/IntelligenceLabel
@onready var strength_label = $Background/LifeEventsContainer/VBoxContainer/StatsPanel/StatsContainer/StrengthLabel
@onready var charisma_label = $Background/LifeEventsContainer/VBoxContainer/StatsPanel/StatsContainer/CharismaLabel
@onready var appearance_label = $Background/LifeEventsContainer/VBoxContainer/StatsPanel/StatsContainer/AppearanceLabel
@onready var luck_label = $Background/LifeEventsContainer/VBoxContainer/StatsPanel/StatsContainer/LuckLabel
@onready var money = $Money
@onready var age_label_month = $Background/LifeEventsContainer/VBoxContainer/AgeContainer/AgeLabelMonth
@onready var work = $Work
var femaleIcon = load("res://MainGamePlay/Assets/female.svg")
var maleIcon = load("res://MainGamePlay/Assets/male.svg")

var currentAgeYears = 0
var currentAgeMonths = 0
const defaultAge = 0
const maxMonths = 11
enum GENDER {FEMALE = 0, MALE = 1}
var gender : GENDER

signal menu_pressed

################################################################################
# Called when the node enters the scene tree for the first time.
################################################################################
func _ready():
	life_events_text.focus_mode = FOCUS_NONE

################################################################################
# Called every frame. 'delta' is the elapsed time since the previous frame.
################################################################################
func _process(delta):
	pass

################################################################################
# Custom function
################################################################################
func setGender(newGender):
	if(newGender == GENDER.FEMALE):
		gender = GENDER.FEMALE
		player_gender.texture = femaleIcon
	elif(newGender == GENDER.MALE):
		gender = GENDER.MALE
		player_gender.texture = maleIcon
		
func setAge( NewAge ):
	currentAgeYears = NewAge
	currentAgeMonths = defaultAge
	age_label_month.text = str(defaultAge)
	age_label.text = str(NewAge)
	
func saveGame():
	var saveData = {}
	saveData.Name = player_name.text
	saveData.AgeInYrs = age_label.text
	saveData.AgeInMos = age_label_month.text
	saveData.Happy = str(happy_progress_bar.value)
	saveData.Health = str(health_progress_bar.value)
	saveData.Intelligence = intelligence_label.text
	saveData.Charisma = charisma_label.text
	saveData.Luck = luck_label.text
	saveData.Apperance = appearance_label.text
	saveData.Strength = strength_label.text
	saveData.LifeText = life_events_text.text
	saveData.Gender = str(gender)
	saveData.merge(money.saveGame())
	SaveLoad.save(saveData)
	
func loadGame():
	var returnType = false
	if(SaveLoad.loadGame()):
		returnType = true
		var loadedData = SaveLoad.getLoadedGameData()
		money.loadGame(loadedData)
		player_name.text = loadedData.Name 
		age_label.text = loadedData.AgeInYrs
		currentAgeYears = int(age_label.text)
		age_label_month.text = loadedData.AgeInMos
		currentAgeMonths = int(age_label_month.text)
		happy_progress_bar.value = float(loadedData.Happy)
		health_progress_bar.value = float(loadedData.Health)
		intelligence_label.text = loadedData.Intelligence
		charisma_label.text = loadedData.Charisma
		luck_label.text = loadedData.Luck
		appearance_label.text = loadedData.Apperance
		strength_label.text = loadedData.Strength
		life_events_text.text = loadedData.LifeText
		setGender(int(loadedData.Gender))
	return returnType
		
	
func reset():
	health_progress_bar.value = 100
	happy_progress_bar.value = 100
	life_events_text.text = "New Life Started"
	pass
################################################################################
# Signals
################################################################################
func _on_money_button_pressed():
	money.show()

func _on_add_month_pressed():
	if( currentAgeMonths == maxMonths ):
		currentAgeMonths = defaultAge
		currentAgeYears += 1 
		age_label_month.text = str(currentAgeMonths)
		age_label.text = str(currentAgeYears)
	else:
		currentAgeMonths += 1
		age_label_month.text = str(currentAgeMonths)
	
	# update happy and health
	happy_progress_bar.value = happy_progress_bar.value - 0.833
	saveGame()
		
func _on_add_year_pressed():
	currentAgeYears += 1
	age_label.text = str(currentAgeYears)
	happy_progress_bar.value = happy_progress_bar.value - 10
	saveGame()
	
	
func _on_work_button_pressed():
	work.show()

func _on_menu_button_pressed():
	menu_pressed.emit()

func _on_school_button_pressed():
	pass
