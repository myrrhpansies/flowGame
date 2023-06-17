extends Node2D
#var gardenPansies = 0
var smalllPansiesss = preload("res://Scenes/small_pansy.tscn")
var smalllSunsss = preload("res://Scenes/small_sun.tscn")
var smalllBellsss = preload("res://Scenes/small_bells.tscn")

func _ready():
	$buttCon/pansyButton.grab_focus()
	
	for i in range(Global.pansyWin):
		var newPansy = smalllPansiesss.instantiate()
		add_child(newPansy)
		newPansy.global_position.x = randi_range(0,500)
		newPansy.global_position.y = randi_range(0,450)
		
		
	for i in range(Global.sunWin):
		var newSun = smalllSunsss.instantiate()
		add_child(newSun)
		newSun.global_position.x = randi_range(0,500)
		newSun.global_position.y = randi_range(0,500)
		
	
	for i in range(Global.sunWin):
		var newBell = smalllBellsss.instantiate()
		add_child(newBell)
		newBell.global_position.x = randi_range(0,500)
		newBell.global_position.y = randi_range(0,500)

func playSounds():
	if Input.is_action_just_pressed("leftArrow") or Input.is_action_just_pressed("rightArrow"):
		$focusSound.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	playSounds()

func addingPansies():
	print("adding a pansy")

func _on_pansy_button_pressed():
	$pressedSound.play()
	get_tree().change_scene_to_file("res://Scenes/PansyScene.tscn")

func _on_sunflower_button_pressed():
	$pressedSound.play()
	get_tree().change_scene_to_file("res://Scenes/sun_scene.tscn")

func _on_bell_button_pressed():
	$pressedSound.play()
	get_tree().change_scene_to_file("res://Scenes/bell_scene.tscn")
