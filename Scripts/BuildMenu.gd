extends Node2D



onready var factoryButton = self.get_node("Factories")
var factories = -1

var currentNation

# Called when the node enters the scene tree for the first time.
func _ready():
	factoryButton.text = "Factories: " + String(factories)
	pass # Replace with function body.

func updateStats(nation):
	currentNation = nation
	factories = nation.factories
	
func _process(_delta):
	factoryButton.text = "Factories: " + String(factories)

func _on_Factories_pressed():
	if currentNation != null:
		print ("more factories")
		currentNation.factories += 1 
		factories = currentNation.factories
