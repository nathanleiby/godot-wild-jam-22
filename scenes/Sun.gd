extends RigidBody2D

const planets = ["Baren", "Desert", "Forest", "Ice", "Lava", "Ocean", "Terran"]

# Called when the node enters the scene tree for the first time.
func _ready():
	# choose a random image
	var planet = random_choice(planets)
	var res = load("res://assets/images/Planets3D/" + planet + ".png") 
	$Sprite.texture = res
	
func random_choice(arr):
	return arr[randi() % arr.size()]