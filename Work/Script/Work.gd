extends Control
@onready var job_list = $Background/MarginContainer/VBoxContainer2/JobList



# Called when the node enters the scene tree for the first time.
func _ready():
	var root = job_list.create_item()
	root.set_text(0,"Jobs available")
	job_list.hide_root = true
	# Entry Level Jobs
	var entryLevel = job_list.create_item(root)
	entryLevel.set_text(0,"Entry Level")
	
	#Intermediate Level Jobs
	var interLevel = job_list.create_item(root)
	interLevel.set_text(0,"Intermediate Level")
	
	#Senior Level Job
	var seniorLevel = job_list.create_item(root)
	seniorLevel.set_text(0,"Senior Level")
	
	#Executive Level Job
	var executiveLevel = job_list.create_item(root)
	executiveLevel.set_text(0,"Executive Level")

	var military = job_list.create_item(root)
	military.set_text(0,"Military")
	var enlisted = job_list.create_item(military)
	enlisted.set_text(0,"Enlisted")
	var officer = job_list.create_item(military)
	officer.set_text(0,"Officer")

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func importJobs():
	pass
	
func _on_return_button_pressed():
	hide()
