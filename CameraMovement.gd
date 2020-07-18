extends Node2D


onready var location = self.get_position()


onready var baseScale = self.get_scale()

var speed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	self.set_position(location)
	if Input.is_action_pressed("mapUp"):
		location.y += speed
	if Input.is_action_pressed("mapDown"):
		location.y -= speed
	if Input.is_action_pressed("mapRight"):
		location.x -= speed
	if Input.is_action_pressed("mapLeft"):
		location.x += speed

func _input(event):
	if event.is_action_pressed("mapSpeed"):
		speed = 5
	if event.is_action_released("mapSpeed"):
		speed = 1
		
	if event.is_action_pressed("scrollDown"):
		self.set_scale(self.get_scale()*0.9)
	if event.is_action_pressed("scrollUp"):
		self.set_scale(self.get_scale()*1.1)
	
	# fix zoom!
	if event.is_action_pressed("z"):
		self.set_scale(baseScale)
	
	# debug stuff
	if event.is_action_pressed("ui_select"):
		print (self.get_position())
