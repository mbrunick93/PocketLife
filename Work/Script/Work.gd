extends Control

var jobDict = {}
var filePath = "res://Work/Assets/Jobs.txt"
@onready var item_list = $Background/MarginContainer/VBoxContainer/ItemList
@onready var label = $Background/MarginContainer/VBoxContainer/Label


enum JOB {	INDEX = 0,
			NAME = 1,
			MONTHLY_PAY = 2,
			RQ_AGE = 3,
			RQ_DG = 4,
			STRESS = 5 }
			
const csvTopRow = 0 			
# Called when the node enters the scene tree for the first time.
func _ready():
	importJobs()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func importJobs():
	var file = FileAccess.open(filePath,FileAccess.READ)
	while !file.eof_reached():
		var data_set = Array(file.get_csv_line())
		jobDict[jobDict.size()] = data_set
	file.close()
	jobDict.erase(csvTopRow)
	for i in jobDict:
		item_list.add_item(jobDict[i][JOB.NAME])
		pass
	
func _on_return_button_pressed():
	hide()

func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	label.text = jobDict[index+1][JOB.NAME]
