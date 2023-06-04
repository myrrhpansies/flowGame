extends Node2D
var notes = 0
var testArray = []
var inputArray = []
var alive = true
@onready var panPlay = $Pansy/AnimationPlayer
@onready var sky = $envCon/envBack
var checkpoint = 0
var deathpoint = 0
var m = 1
var looping = true
var weatherGoing = false
@onready var blocks = [$dayCounter/HBoxContainer/ColorRect1, $dayCounter/HBoxContainer/ColorRect2, $dayCounter/HBoxContainer/ColorRect3, $dayCounter/HBoxContainer/ColorRect4, $dayCounter/HBoxContainer/ColorRect5, $dayCounter/HBoxContainer/ColorRect6, $dayCounter/HBoxContainer/ColorRect7, $dayCounter/HBoxContainer/ColorRect8, $dayCounter/HBoxContainer/ColorRect9, $dayCounter/HBoxContainer/ColorRect10, $dayCounter/HBoxContainer/ColorRect11, $dayCounter/HBoxContainer/ColorRect12,]


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$sun.sunPressed.connect(sunny)
	$rain.rainPressed.connect(rainy)
	$cloud.cloudPressed.connect(cloudy)
	generateArray()

func generateArray():
	var z = 0
	while z < 12:
		z+= 1
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var num = rng.randi_range(1, 3)
		testArray.push_back(num)
		print(testArray)
	
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

#######################resetting array (not working right####################
func followMe():
	if alive:
		checkNotes()
		looping = true
		inputArray = []
		notes = 0
		print("inputArray " + str(inputArray))
		$playTimer.start()

func checkingShit():
	print(str(notes) + " notes")
	print("m" + str(m))
	print("inputArray" + str(inputArray))


#############recieving user input###################################

func sunny():
	if alive:
		inputArray.push_back(1)
		notes += 1
		checkingShit()
		if notes == m:
			var tween = get_tree().create_tween()
			tween.tween_property(sky, "modulate", Color8(233,238,240,255), 1)
			$envCon/envAnimations.queue("sunFlow")
			blocks[notes - 1].modulate = Color8(248,216,102,255)
			m += 1
			followMe()

func rainy():
	if alive:
		inputArray.push_back(2)
		notes += 1	
		checkingShit()
		if notes == m:
			var tween = get_tree().create_tween()
			tween.tween_property(sky, "modulate", Color8(235,236,217,237), 1)
			$envCon/envAnimations.queue("rainFlow")
			blocks[notes - 1].modulate = Color8(110,120,129,255)
			m += 1
			followMe()

func cloudy():
	if alive:
		inputArray.push_back(3)
		notes += 1	
		checkingShit()
		if notes == m:
			var tween = get_tree().create_tween()
			tween.tween_property(sky, "modulate", Color8(240,246,247,255), 1)
			$envCon/envAnimations.queue("cloudFlow")
			blocks[notes - 1].modulate = Color8(164,217,231,255)
			m += 1
			followMe()
					
		
#############Checking that the user input is the same as the computer Array###########
func checkNotes():
	if testArray.slice(0,notes) != inputArray.slice(0,m):
		alive = false
		inputArray = []
		$deathTImer.start()
		
		
############### animations #############################		
func noteCheckpoints():
	if alive and notes == 3 and checkpoint == 0:
		checkpoint += 1
		deathpoint += 1
		panPlay.play("sproutWin")
		await panPlay.animation_finished
		panPlay.play("shootRest")
	elif alive and notes == 6 and checkpoint == 1:
		checkpoint += 1
		deathpoint += 1
		panPlay.play("shootWin")
		await panPlay.animation_finished
		panPlay.play("growRest")
	elif alive and notes == 9 and checkpoint == 2:
		checkpoint += 1
		deathpoint += 1
		panPlay.play("growWin")
		await panPlay.animation_finished
		panPlay.play("BloomRest")	
	elif alive and notes == 12 and checkpoint == 3:
		checkpoint += 1
		deathpoint += 1
		panPlay.play("BloomWin")
		await panPlay.animation_finished
		panPlay.play("fullGrown")
		$dayCounter.visible = true	
		
func deathPoints():
	if !alive and deathpoint == 0:
		panPlay.play("sproutDeath")
		notes = 0
	if !alive and deathpoint == 1:
		panPlay.play("shootDeath")
		notes = 0
	elif !alive and deathpoint == 2 :
		panPlay.play("growthDeath")	
		inputArray = []
	elif !alive and deathpoint == 3:
		panPlay.play("bloomDeath")
		inputArray = []
	else:
		pass	

###############misc.#######################################

func _process(_delta):
	noteCheckpoints()
	deathPoints()
	checkNotes()

func _on_timer_timeout():
	if alive:
		playAlong()

func _on_play_timer_timeout():
	if alive:
		playAlong()


func _on_death_t_imer_timeout():
	$pansyDeath.visible = true
	$pansyDeath/yes.grab_focus()
	$cloud.visible = false
