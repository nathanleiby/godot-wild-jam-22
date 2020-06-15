extends Line2D

export var maxTrailLength = 500
var target
export(NodePath) var targetPath

# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_node(targetPath)

func _process(delta):
	global_position = Vector2(0,0)
	global_rotation = 0
	var pt = target.global_position
	add_point(pt)
	while get_point_count() > maxTrailLength:
		remove_point(0)