extends CollisionShape2D



#export(String) var landName = self.name
onready var landName = self.name
var occupyingPlayer
var factories = 0

export(int) var units = 0

# What team you're on
export(String) var team = "Neutral"

export(Array, String) var connectedNations
#export(GDScript) var connectedNation1

# get the factory icon!
onready var factoryIcon = self.get_node("factoryIcon")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func addFactory(numFactories):
	factories += numFactories
	if factories > 0:
		factoryIcon.visible = true
	else:
		factoryIcon.visible = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
