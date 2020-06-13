extends Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Button").connect("pressed", self, "_on_Button_pressed")

func _on_Button_pressed():
	get_tree().change_scene("res://Game.tscn")