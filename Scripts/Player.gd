extends Node2D



export(bool) var playerControlled = false




# Player's color
onready var color = self.modulate

# Array of all nations.
onready var nations = get_tree().get_nodes_in_group("Nation")

# Lands this player controls
onready var controlledNations = get_tree().get_nodes_in_group("Nation" + self.name)








# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func paintNations():
	
	for item in controlledNations:
		item.modulate = color


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
