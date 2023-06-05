extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$buttCon/pansyButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pansy_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/PansyScene.tscn")


func _on_sunflower_button_pressed():
	print("sunflowerPress")


func _on_bell_button_pressed():
	print("bellflowerPress")


func _on_question_button_pressed():
	print("questionPress")
