extends Path2D

var tween
func _ready():
	tween = Tween.new()
	add_child(tween)
	tween.interpolate_property($PathFollow2D, "unit_offset", 0, 1, 6, tween.TRANS_LINEAR, tween.EASE_IN_OUT)
	tween.set_repeat(true)
	tween.start()
	
func _process(delta):
	pass
