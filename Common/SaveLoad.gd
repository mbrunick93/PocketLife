extends Node


################################################################################
# Attributes
################################################################################
var saveFile = "user://game.dat"
var loadedData 

################################################################################
# Custom functions
################################################################################
func saveFileExist():
	return FileAccess.file_exists(saveFile)
	
func deleteSave():
	DirAccess.remove_absolute(saveFile)

func loadGame():
	var returnType = false
	var file = FileAccess.open(saveFile,FileAccess.READ)
	var json_string = file.get_as_text()
	var json = JSON.new()
	var parse_result = json.parse(json_string, true)
	if parse_result == OK:
		returnType = true
		loadedData = json.data
	return returnType

func getLoadedGameData():
	return loadedData

func save(dataToBeSaved):
	var file = FileAccess.open(saveFile,FileAccess.WRITE)
	if file == null:
		return
	var json_string = JSON.stringify(dataToBeSaved,"\t")
	file.store_string(json_string)
