extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var thrust = Vector2(0, 200)
var torque = 20000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _integrate_forces(state):
	if Input.is_action_pressed("ui_up"):
		set_applied_force(state.total_gravity + thrust.rotated(rotation))
	else:
		set_applied_force(Vector2(0,0))
	var t = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	set_applied_torque(torque * t)