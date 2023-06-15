extends Node2D
var notes = 0
var testArray = []
var inputArray = []
var alive = true
@onready var panPlay = $Pansy/AnimationPlayer
@onready var sky = $envCon/envBack
@onready var skyAnimations = $envCon/skyAnimations
var checkpoint = 0
var deathpoint = 0
var m = 1
var skyNum = 0
var looping = true
var weatherGoing = false
@onready var blocks = [$dayCounter/HBoxContainer/ColorRect1, $dayCounter/HBoxContainer/ColorRect2, $dayCounter/HBoxContainer/ColorRect3, $dayCounter/HBoxContainer/ColorRect4, $dayCounter/HBoxContainer/ColorRect5, $dayCounter/HBoxContainer/ColorRect6, $dayCounter/HBoxContainer/ColorRect7, $dayCounter/HBoxContainer/ColorRect8, $dayCounter/HBoxContainer/ColorRect9, $dayCounter/HBoxContainer/ColorRect10, $dayCounter/HBoxContainer/ColorRect11, $dayCounter/HBoxContainer/ColorRect12,]
signal addPansies

func _ready():
	global.pansyyy = self
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$sun.sunPressed.connect(sunny)
	$rain.rainPressed.connect(rainy)
	$cloud.cloudPressed.connect(cloudy)
	generateArray()
	print(self)
	print(global.pansyyy)
	


func generateArray():
	var z = 0
	while z < 12:
		z+= 1
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var num = rng.randi_range(1, 3)
		testArray.push_back(num)
		print(testArray)

func diableButtons():
	if looping == true:
		$sun.disabled = true
		$cloud.disabled = true
		$rain.disabled = true
	elif looping == false:
		$sun.disabled = false
		$cloud.disabled = false
		$rain.disabled = false

func playAlong():
	var k = 0
	if looping == true:
		for i in testArray.slice(0,m):
			print(m)
			print(k)
			if i == 1:
				k += 1
				$sunBeep2.play()
				$falseSun.visible = true
				await $sunBeep2.finished
				$falseSun.visible = false
				if m == k :
					looping = false
					print("catch")
			if i == 2:
				k += 1
				$rainBeep2.play()
				$falseRain.visible = true
				await $rainBeep2.finished
				$falseRain.visible = false
				if m == k :
					looping = false
					print("catch")
			if i == 3:
				k += 1
				$cloudBeep2.play()
				$falseCloud.visible = true
				await $cloudBeep2.finished
				$falseCloud.visible = false
				if m == k :
					looping = false
					print("catch")
					

#######################resetting array (not working right####################
func followMe():
	if alive:
		checkNotes()
		looping = true
		inputArray = []
		notes = 0
		print("inputArray " + str(inputArray))
		$Timer.start()

func checkingShit():
	print(str(notes) + " notes")
	print("m" + str(m))
	print("inputArray" + str(inputArray))


#############recieving user input###################################
func sunny():
	if alive:
		print("skyNum" + str(skyNum))
		inputArray.push_back(1)
		notes += 1
		if notes == m:
			if m == 1:
				skyAnimations.play("blueFadeIn")
				await skyAnimations.animation_finished
				$envCon/blueSky2.visible = true
			if skyNum == 2:
				$envCon/skyAnimations.play("greyFadeOut")	
			$envCon/envAnimations.queue("sunFlow")
			blocks[notes - 1].modulate = Color8(248,216,102,255)
			skyNum = 1
			m += 1
			$followTimer.start()

func rainy():
	if alive:
		print("skyNum" + str(skyNum))
		inputArray.push_back(2)
		notes += 1	
		if notes == m:
			if m == 1:
				skyAnimations.play("greyFadeIn")
				await skyAnimations.animation_finished
				$envCon/blueSky2.visible = true
			$envCon/envAnimations.queue("rainFlow")
			if skyNum == 1 or skyNum == 3:
				$envCon/skyAnimations.play("greyFadeIn")
			blocks[notes - 1].modulate = Color8(110,120,129,255)
			skyNum = 2
			m += 1
			$followTimer.start()

func cloudy():
	if alive:
		print("skyNum" + str(skyNum))
		inputArray.push_back(3)
		notes += 1	
		if notes == m:
			if m == 1:
				skyAnimations.play("blueFadeIn")
				await skyAnimations.animation_finished
				$envCon/blueSky2.visible = true
			$envCon/envAnimations.queue("cloudFlow")
			if skyNum == 2:
				$envCon/skyAnimations.play("greyFadeOut")
			blocks[notes - 1].modulate = Color8(164,217,231,255)
			skyNum = 3
			m += 1
			$followTimer.start()
		
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
		$winTimer.start()
		
func deathPoints():
	if !alive and deathpoint == 0:
		panPlay.play("sproutDeath")
		notes = 0
	if !alive and deathpoint == 1:
		panPlay.play("shootDeath")
		notes = 0
	elif !alive and deathpoint == 2 :
		panPlay.play("growthDeath")	
		notes = 0
	elif !alive and deathpoint == 3:
		panPlay.play("bloomDeath")
		notes = 0
	else:
		pass	

###############misc.#######################################

func _process(_delta):
	noteCheckpoints()
	deathPoints()
	checkNotes()
	diableButtons()

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


func _on_win_timer_timeout():
	$dayCounter.visible = true	
	var countTheDays = 0
	for i in testArray:
		blocks[countTheDays].modulate = Color8(255,255,255,255)
		if i == 1:
			print(i)
			countTheDays += 1
			$Pansy/AnimationPlayer.play("singLeft")
			$sunBeep2.play()
			await $sunBeep2.finished
			$Pansy/AnimationPlayer.stop()
		if i == 2:
			print(i)
			countTheDays += 1
			$Pansy/AnimationPlayer.play("singRight")
			$rainBeep2.play()
			await $rainBeep2.finished
			$Pansy/AnimationPlayer.stop()
		if i == 3:
			print(i)
			countTheDays += 1
			$Pansy/AnimationPlayer.play("singUp")
			$cloudBeep2.play()
			await $cloudBeep2.finished
			$Pansy/AnimationPlayer.stop()
			
func _on_follow_timer_timeout():
	followMe()
