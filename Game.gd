extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal game_start(value1, value2)

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("game_start", true, 42)
	$Timer.connect("timeout", self, "_on_Timer_timeout")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	$Sprite.visible = !$Sprite.visible