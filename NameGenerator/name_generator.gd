extends Node

var maleNames : PackedStringArray
var femaleNames : PackedStringArray
var lastNames : PackedStringArray

const maleList = "res://NameGenerator/NameLists/male.txt"
const femaleList = "res://NameGenerator/NameLists/female.txt"
const lastNameList = "res://NameGenerator/NameLists/last.txt"

enum GENDER	 { FEMALE = 0,
				MALE = 1,
				MIXED = 2}

# Called when the node enters the scene tree for the first time.
func _ready():
	maleNames = initializeNameLists(maleList)
	femaleNames = initializeNameLists(femaleList)
	lastNames = initializeNameLists(lastNameList)

func initializeNameLists(path):
	var list : PackedStringArray
	var file = FileAccess.open(path,FileAccess.READ)
	while file.get_position() < file.get_length():
		list.append(file.get_line())
	file.close()
	return list

func getMaleName():
	var rng = RandomNumberGenerator.new()
	var firstName = maleNames[rng.randi_range(0,maleNames.size()-1)]
	var lastName = lastNames[rng.randi_range(0,lastNames.size()-1)]
	var maleDict = {}
	var maleName = firstName+" "+lastName
	maleDict[maleName] = "Male"
	return maleDict
	
func getFemaleName():	
	var rng = RandomNumberGenerator.new()
	var firstName = femaleNames[rng.randi_range(0,femaleNames.size()-1)]
	var lastName = lastNames[rng.randi_range(0,lastNames.size()-1)]
	var femaleDict = {}
	var femaleName = firstName+" "+lastName
	femaleDict[femaleName] = "Female"
	return femaleDict

func getListOfNames(numOfNames,Gender=GENDER.MIXED):
	var listOfNames = {}
	if (Gender == GENDER.MALE):
		for i in range(0,numOfNames):
			listOfNames.merge(getMaleName())
	elif (Gender == GENDER.FEMALE):
		for i in range(0,numOfNames):
			listOfNames.merge(getFemaleName())
	else:
		var rng = RandomNumberGenerator.new()
		for i in range(0,numOfNames):
			var g = rng.randi_range(GENDER.FEMALE,GENDER.MALE)
			if (g == GENDER.FEMALE):
				listOfNames.merge(getFemaleName())
			else:
				listOfNames.merge(getMaleName())	
	return listOfNames	
	
	
