extends Node2D
var notes = 0
var testArray = [1,1,1,1]
var inputArray = []

func _ready():
	print(testArray.slice(0,2))
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func arrowPress():
	if Input.is_action_just_pressed("leftArrow"):
		inputArray.push_back(1)
		notes += 1
		print(inputArray)
	elif Input.is_action_just_pressed("rightArrow"):
		inputArray.push_back(2)
		notes += 1	
		print(inputArray)
	elif Input.is_action_just_pressed("downArrow"):
		inputArray.push_back(3)
		notes += 1	
		print(inputArray)

func checkNotes():
	if notes == 0:
		pass
	elif notes == 1:
		if testArray[0] != inputArray[0]:
			notes = 0
			print("you lose")
			inputArray = []
	elif testArray.slice(0,notes) != inputArray.slice(0,notes):
			notes = 0
			print("you lose")
			inputArray = []
		
func _process(delta):
	arrowPress()
	checkNotes()
	

