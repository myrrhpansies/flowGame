extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$yes.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_yes_pressed():
	get_tree().change_scene_to_file("res://Scenes/PansyScene.tscn")



func _on_no_pressed():
	print("pettt")
