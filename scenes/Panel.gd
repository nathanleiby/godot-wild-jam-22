extends Panel

onready var button: Button = get_node("button")

# Called when the node enters the scene tree for the first time.
func _ready():
	button.connect("pressed", self, "_on_Button_pressed")
	
func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Game.tscn")