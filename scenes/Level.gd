extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var visited_quadrants = [false, false, false, false]
var canExit = false
var LevelScene = load("res://scenes/Level.tscn")
var WinLoseScene = preload("res://scenes/WinLose.tscn")
var winLose
var debugMode = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	Engine.time_scale = 1
		
	pass
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_ASCIITILDE || event.scancode == KEY_QUOTELEFT:
			debugMode = not debugMode
			print("DEBUG MODE = ", debugMode)
		if event.scancode == KEY_R:
			restart()
		if debugMode and event.scancode == KEY_W:
			win()
		if debugMode and event.scancode == KEY_L:
			lose()
		#if event.scancode == KEY_P:
		#	print("pause")
		#	pause() # can't pause directly, b/c breaks processing of input
			

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
	
	# If all visitied, enable the exit portal
	for i in visited_quadrants:
		if i == false:
			return

	$Portal/AnimatedSprite.animation = "blue"
	canExit = true


# func pause():
#	get_tree().paused = not get_tree().paused
		
func restart():
	if winLose != null:
		winLose.queue_free()
	
	get_parent().add_child(LevelScene.instance())
	self.queue_free()

func lose():
	# slo-mo
	Engine.time_scale = .5
	
	# wait...
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	
	get_tree().paused = true
	winLose = WinLoseScene.instance()
	winLose.get_node("Outcome").bbcode_text = "[center]YOU LOSE[/center]"
	# winLose.get_node("ColorRect").color = 'RED'
	
	winLose.get_node("Button").connect("pressed", self, "_on_WinLose_button_pressed")
	add_child(winLose)
	
func win():
	get_tree().paused = true
	winLose = WinLoseScene.instance()
	winLose.get_node("Button").connect("pressed", self, "_on_WinLose_button_pressed")
	add_child(winLose)
	

func _on_Portal_body_entered(body):
	if canExit:
		win()

func _on_WinLose_button_pressed():
	print("on_WinLose_button_pressed")
	restart()

func _on_DeathZone_body_entered(body):
	print("_on_DeathZone_body_entered")
	if body.name != "Player":
		return

	lose()
