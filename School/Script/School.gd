extends Control

################################################################################
# Attributes
################################################################################
@onready var education_label = $Panel/MarginContainer/HBoxContainer/EducationLabel

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

################################################################################
# Called when the node enters the scene tree for the first time.
################################################################################
func _ready():
	pass # Replace with function body.

################################################################################
# Called every frame. 'delta' is the elapsed time since the previous frame.
################################################################################
func _process(delta):
	pass

################################################################################
# Custom Functions
################################################################################
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
