extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var q = [false, false, false, false]

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
		
	print("Updating visited quadrants...")
	q[quadrant_idx] = true
	print(q)
	
	# If all visitied, win!	
	for i in q:
		if i == false:
			return
	
	print("Win!")
				
			
			
		