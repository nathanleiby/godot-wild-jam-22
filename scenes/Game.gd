extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var visited_quadrants = [false, false, false, false]
var canExit = false
var winLose = preload("res://scenes/WinLose.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Quadrant_body_entered(body):
	markIfPlayerEnteredQuadrant(body, 0)	

func _on_Quadrant2_body_entered(body):
	markIfPlayerEnteredQuadrant(body, 1)

func _on_Quadrant3_body_entered(body):
	markIfPlayerEnteredQuadrant(body, 2)

func _on_Quadrant4_body_entered(body):
	markIfPlayerEnteredQuadrant(body, 3)
		
func markIfPlayerEnteredQuadrant(body, quadrant_idx):
	if body.name != "Player":
		return
		
	visited_quadrants[quadrant_idx] = true
	
	# If all visitied, win!	
	for i in visited_quadrants:
		if i == false:
			return

	revolutionComplete()
		
func revolutionComplete():
	$Portal/AnimatedSprite.animation = "blue"
	canExit = true
	
func _on_Portal_body_entered(body):
	if not canExit:
		return
		
	get_tree().paused = true
	add_child(winLose.instance())
	print("you win!")