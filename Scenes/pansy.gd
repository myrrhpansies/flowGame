extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$pansyScene.playStart.connect(test)

func test():
	print("hey")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
