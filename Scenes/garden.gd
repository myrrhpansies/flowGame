extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$buttCon/pansyButton.grab_focus()

func playSounds():
	if Input.is_action_just_pressed("leftArrow") or Input.is_action_just_pressed("rightArrow"):
		$focusSound.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pansy_button_pressed():
	$pressedSound.play()
	get_tree().change_scene_to_file("res://Scenes/PansyScene.tscn")

