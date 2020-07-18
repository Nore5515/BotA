extends Node2D


onready var playerNations = get_tree().get_nodes_in_group("player")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func getPlayerByTeam(checkTeam):
	if playerNations != null:
		for player in playerNations:
			if player.team == checkTeam:
				return player
	else:
		print ("WAGGG")
	return null

func getCurrentPlayer():
	if playerNations != null:
		for player in playerNations:
			if player.isCurrent:
				return player
	else:
		print ("WAGGG")
	return null
