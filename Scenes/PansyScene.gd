extends Node2D
var notes = 0
var testArray = [1,1,1,1,1,1,1,1,1,1,1,1]
var inputArray = []
var alive = true
@onready var panPlay = $Pansy/AnimationPlayer
var checkpoint = 0
func _ready():
	print(testArray.slice(0,2))
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func playNotes():
	pass
func arrowPress():
	if Input.is_action_just_pressed("leftArrow") or Input.is_action_just_pressed("A"):
		inputArray.push_back(1)
		notes += 1
		print(inputArray)
	elif Input.is_action_just_pressed("rightArrow") or Input.is_action_just_pressed("D"):
		inputArray.push_back(2)
		notes += 1	
		print(inputArray)
	elif Input.is_action_just_pressed("downArrow") or Input.is_action_just_pressed("S"):
		inputArray.push_back(3)
		notes += 1	
		print(inputArray)

func checkNotes():
	if notes == 0:
		pass
	elif notes == 1:
		if testArray[0] != inputArray[0]:
			!alive
			notes = 0
			print("you lose")
			inputArray = []
	elif testArray.slice(0,notes) != inputArray.slice(0,notes):
			!alive
			notes = 0
			print("you lose")
			inputArray = []
		
func noteCheckpoints():
		if alive and notes == 3 and checkpoint == 0:
			checkpoint += 1
			panPlay.play("sproutWin")
			await panPlay.animation_finished
			panPlay.play("shootRest")
		elif alive and notes == 6 and checkpoint == 1:
			checkpoint += 1
			panPlay.play("shootWin")
			await panPlay.animation_finished
			panPlay.play("growRest")
		elif alive and notes == 9 and checkpoint == 2:
			checkpoint += 1
			panPlay.play("growWin")
			await panPlay.animation_finished
			panPlay.play("BloomRest")	
		elif alive and notes == 12 and checkpoint == 3:
			checkpoint += 1
			panPlay.play("BloomWin")
			await panPlay.animation_finished
			panPlay.play("fullGrown")	
		


func _process(delta):
	arrowPress()
	checkNotes()
	noteCheckpoints()
	
	



