extends HSlider


onready var unitNum = self.get_child(0)

onready var papaCollision = get_tree().get_nodes_in_group("nation_collision")[0]

var recieve
var send

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	unitNum.text = String(self.value)


func processTransfer(receivingNation, sendingNation):
	#receivingNation.units += sendingNation.units
	#sendingNation.units = 0
	recieve = receivingNation
	send = sendingNation
	if send.units == 0:
		pass
	else:
		self.max_value = send.units
		self.value = self.max_value

func speedTransfer():
	recieve.units += self.value
	send.units -= self.value
	self.value = 0
	self.max_value = 1
	papaCollision.doubleClickTransfer = false

func _on_confirmButton_pressed():
	if recieve != null:
		recieve.units += self.value
		send.units -= self.value
		self.value = 0
		self.max_value = 1
	papaCollision.doubleClickTransfer = false
	
func _on_cancelButton_pressed():
	recieve = null
	send = null
	self.value = 0
	self.max_value = 1
	papaCollision.doubleClickTransfer = false
