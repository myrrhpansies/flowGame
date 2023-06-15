extends Node2D
var gardenPansies = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$buttCon/pansyButton.grab_focus()


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
