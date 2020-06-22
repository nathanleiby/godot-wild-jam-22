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
var outOfBoundsTimer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	Engine.time_scale = 1
	$Player.connect("exiting_view", self, "_on_Player_exiting_view")
	$Player.connect("entering_view", self, "_on_Player_entering_view")
	
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
			lose("-- FORCED ERROR --\n\nYou pressed l. That was your own doing!")
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

	
func restart():
	if winLose != null:
		winLose.queue_free()
	
	get_parent().add_child(LevelScene.instance())
	self.queue_free()

func lose(text):
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
	winLose.get_node("RichTextLabel").bbcode_text = "[center]" + str(text) + "[/center]"
	# winLose.get_node("ColorRect").color = 'RED'
	winLose.get_node("Button").connect("pressed", self, "_on_WinLose_button_pressed")
	add_child(winLose)
	
func win():
	get_tree().paused = true
	winLose = WinLoseScene.instance()
	
	var text = "-- REVOLUTION --\n\nYou looped the loop. Well done!"
	winLose.get_node("RichTextLabel").bbcode_text = "[center]" + str(text) + "[/center]"
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

	lose("-- CRASH LANDING --\n\nFrom blazing meteor to buried meteorite, you are now smooshed into the ground.")

func _on_Player_entering_view():
	if outOfBoundsTimer == null:
		return
	outOfBoundsTimer.stop()
	outOfBoundsTimer.queue_free()

func _on_Player_exiting_view():
	if not outOfBoundsTimer == null:
		return
	outOfBoundsTimer = Timer.new()
	outOfBoundsTimer.set_wait_time(1)
	outOfBoundsTimer.connect("timeout", self, "_on_outOfBoundsTimer_timeout")
	add_child(outOfBoundsTimer)
	outOfBoundsTimer.start()
	

func _on_outOfBoundsTimer_timeout():
	if (randf() > 0.5):
		lose("-- LOST IN SPACE --\n\nYou drift off into the sweet, peaceful darkness.")
	else:
		# TODO: Show this if velocity as you exit is quite high
		lose("-- BOLDLY GO --\n\nWhoosh! You're off to where no one has gone before.")