extends Sprite

# popping out and stuff
onready var displayPosition = self.get_position()
onready var hiddenPosition = Vector2(displayPosition.x, displayPosition.y-40)

# get the player handler
onready var playerHandler = get_tree().get_nodes_in_group("playerList")[0]

# get the nation handler
onready var nationHandler = get_tree().get_nodes_in_group("nation_collision")[0]

# test!
#onready var factoryIcon = get_tree().get_nodes_in_group("test")[0]


# load custom building adder cursor
var addBuildingCursor = load("res://PNGs/buildingSymbol.png")
var buildCursor = false

# the current player
var currentPlayer




# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_position(hiddenPosition)

func _process(delta):
	updatePlayer()
	
	if currentPlayer != null:
		self.get_child(0).text = String(currentPlayer.industry)
	else:
		print ("WA")

func updatePlayer():
	currentPlayer = playerHandler.getCurrentPlayer()

func _on_MainButton_pressed():
	if self.get_position() == hiddenPosition:
		self.set_position(displayPosition)
	else:
		self.set_position(hiddenPosition)


func _on_AddButton_pressed():
	if buildCursor:
		Input.set_custom_mouse_cursor(null)
	else:
		Input.set_custom_mouse_cursor(addBuildingCursor)
	buildCursor = !buildCursor
