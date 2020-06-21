extends TextureRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	# choose a random image
	var num = random_choice([4,2,6])
	print(num)
	var res = load("res://assets/images/Space/PNG/Space_Stars" + str(num) + ".png") 
	self.texture = res

func random_choice(arr):
	return arr[randi() % arr.size()]
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
