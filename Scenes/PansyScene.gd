extends Node2D
var notes = 0
var testArray = [1,2,3]
var inputArray = []
var alive = true
@onready var panPlay = $Pansy/AnimationPlayer
var checkpoint = 0
var deathpoint = 0
var m = 1
var looping = true


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			
func playAlong():
	if looping == true:
		for i in testArray.slice(0,m):
			if i == 1:
				$sunBeep2.play()
				$falseSun.visible = true
				await $sunBeep2.finished
				$falseSun.visible = false
			if i == 2:
				$rainBeep2.play()
				$falseRain.visible = true
				await $rainBeep2.finished
				$falseRain.visible = false
			if i == 3:
				$cloudBeep2.play()
				$falseCloud.visible = true
				await $cloudBeep2.finished
				$falseCloud.visible = false

func arrowPress():
	print("m" + str(m))
	print("inputArray" + str(inputArray))
	if alive and Input.is_action_just_pressed("leftArrow"):
		m +=1
		inputArray.push_back(1)
		notes += 1
	elif alive and Input.is_action_just_pressed("rightArrow"):
		m +=1
		inputArray.push_back(2)
		notes += 1	
	elif alive and Input.is_action_just_pressed("downArrow"):
		m +=1
		inputArray.push_back(3)
		notes += 1	
	else:
		pass	

func checkNotes():
	if notes == 0:
		pass
	elif notes >= 1 and testArray.slice(0,notes) != inputArray.slice(0,notes):
		alive = false
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
		
func deathPoints():
	if !alive and deathpoint == 0 and notes <=3 :
		deathpoint += 1
		panPlay.play("sproutDeath")
		notes = 0
	if !alive and deathpoint == 0 and notes >3 and notes <= 6:
		deathpoint += 1
		panPlay.play("shootDeath")
		notes = 0
	elif !alive and deathpoint == 0 and notes >6 and notes <= 9:
		deathpoint += 1
		panPlay.play("growthDeath")	
		inputArray = []
	elif !alive and deathpoint == 0 and notes >9 and notes <= 12:
		deathpoint += 1
		panPlay.play("bloomDeath")
		
	else:
		pass	

func _process(delta):
	arrowPress()
	checkNotes()
	noteCheckpoints()
	deathPoints()


func _on_timer_timeout():
	playAlong()
