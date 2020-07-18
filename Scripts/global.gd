extends Node2D


# DIR OF NATION SCRIPTS
var nationDir = {}

# ARRAY OF ALL NATIONS IN NATION GROUP
onready var nations = get_tree().get_nodes_in_group("Nation")

# ARRAY OF ALL UNITS
onready var units = get_tree().get_nodes_in_group("Unit")

# ARRAY OF ALL PLAYERS
onready var players = get_tree().get_nodes_in_group("Player")

# ARRAY OF ALL PLAYERS COLORS
var playerColors = []

# ARRAY OF ALL PLAYER CONTROLLED PLAYERS
onready var pcPlayers = []

# BUILD MENU
onready var buildMenu = get_tree().get_nodes_in_group("BuildMenu")[0]

# POPUP
onready var popups = get_tree().get_nodes_in_group("Popup")
onready var popup = popups[0]

# SELECTED NATION
var selectedNation = -1

# CURRENT PLAYER
var currentPlayer
var currentPlayerCount = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for item in nations:
		nationDir[item.landName] = item

	for n in range (players.size()):
		if players[n].playerControlled:
			pcPlayers.append(players[n]) 

	if pcPlayers.size() > 0:
		currentPlayer = pcPlayers[0]
		currentPlayerCount = 0
	else:
		print("ERR")

	for unit in units:
		unit.get_node("Button").connect("pressed", self, "unitPressed")

	for n in range (players.size()):
		playerColors.append(players[n].modulate)
	print (playerColors)

	paintAllNations()



func unitPressed():
	print ("WAHOO")



func _process(_delta):
	if selectedNation != -1:
		paintAllNations()
		nationDir["icon" + String(selectedNation)].modulate = currentPlayer.color



func paintAllNations():
	
	for nation in nations:
		nation.modulate = Color(1,1,1)
	
	for player in players:
		player.paintNations()



func nextTurn():
	
	for i in range (nations.size()):
		units[i].unitCount += nations[i].factories



func _on_NationClicker_clickedNation(clickedNation):
	#buildMenu[0].updateStats(nations[nationNumber])
	print("Nation " + clickedNation.name + " clicked!")
	popup.set_position(clickedNation.get_global_transform().origin)
	popup.get_child(0).text = String(clickedNation.factories)
	buildMenu.visible = true
	selectedNation = -1
	#selectedNation = clickedNation



func _on_NextTurnButton_pressed():
	nextTurn()



func _on_SwapPlayerButton_pressed():
	currentPlayerCount += 1
	#if currentPlayerCount > pcPlayers.size() - 1:
	if currentPlayerCount > players.size() - 1:
		currentPlayerCount = 0
	currentPlayer = players[currentPlayerCount]

