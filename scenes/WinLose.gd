extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	# Still process events here, so we can respond to button presses even at game end when the background is paused
	# https://docs.godotengine.org/en/3.1/classes/class_node.html#enum-node-pausemode
	pause_mode = PAUSE_MODE_PROCESS

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
