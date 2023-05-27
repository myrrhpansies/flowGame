extends Node2D
var notes = 0
var testArray = [1,2,3]
var inputArray = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func arrowPress():
	if Input.is_action_just_pressed("leftArrow"):
		inputArray.push_front(1)
		notes += 1
		print(inputArray)
	elif 	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func checkNotes():
	if notes == 0:
		pass
	elif notes == 1:
		if testArray[0] == inputArray[0]:
			pass
		else:
			print("you lose")	
	elif notes == 2:
		pass
	elif notes == 3:
		pass				
func _process(delta):
	arrowPress()
	checkNotes()

func _on_sun_focus_entered():
	pass # Replace with function body.
