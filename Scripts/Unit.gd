extends Node2D


var movement = 1
var unitCount = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_node("UnitCount").text = String(unitCount)
	pass # Replace with function body.


func _process(_delta):
	self.get_node("UnitCount").text = String(unitCount)

