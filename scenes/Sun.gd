extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var mustCross1: Line2D = $LineToCross1
onready var mustCross2: Line2D = $LineToCross2
onready var mustCross3: Line2D = $LineToCross3

const length = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	mustCross1.add_point(Vector2(0,0))
	mustCross1.add_point(Vector2(-length, length))

	mustCross2.add_point(Vector2(0,0))
	mustCross2.add_point(Vector2(length, length))

	mustCross3.add_point(Vector2(0,0))
	mustCross3.add_point(Vector2(length, -length))