extends RigidBody2D

export var vel: Vector2 = Vector2(0,0)
onready var particles: Particles2D = $Particles2D

# Called when the node enters the scene tree for the first time.
func _ready():
	linear_velocity = vel

func _process(delta):		
	# particles.process_material.set("fake", -1 * linear_velocity)
	# particles.process_material.set("initial_velocity", -5-)
	## particles.process_material. = -1 * linear_velocity.angle()
	pass