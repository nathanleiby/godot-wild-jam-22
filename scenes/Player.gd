extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var thrust = Vector2(0, 200)
export var torque = 20000

signal exiting_view
signal entering_view

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

# func _on_VisibilityNotifier2D_screen_entered():
	# pass # Replace with function body.


func _on_VisibilityNotifier2D_viewport_entered(viewport):
	print("viewport entered")
	pass # Replace with function body.

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	print("viewport exited")
	pass # Replace with function body.

func _on_VisibilityNotifier2D_screen_entered():
	print("screen entered")
	emit_signal("entering_view")
	pass # Replace with function body.

func _on_VisibilityNotifier2D_screen_exited():
	print("screen exited")
	emit_signal("exiting_view")
	pass # Replace with function body.
