extends Node2D


onready var nations = get_tree().get_nodes_in_group("Nation")

# to make arrows!
onready var nationCollision = get_tree().get_nodes_in_group("nation_collision")[0]

# to use its attack thingy
onready var nextTurnButton = get_tree().get_nodes_in_group("nextTurn")[0]

# get the base nation color
onready var baseColor = nations[0].get_child(0).modulate


# end game conditions
signal victory()
var allAllies = false
var allEnemies

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	
	# this will disable if a SINGLE nation is not allied.
	allAllies = true
	# similar but enemies
	allEnemies = true
	
	# paint nation's color based on their nation
	for nation in nations:
		if nation.team == "Allies":
			nation.get_child(1).modulate = Color( 0.37, 0.62, 0.63, 1 )
			# if a SINGLE enemy stands, the game isn't over yet!
			allEnemies = false
		elif nation.team == "Enemies":
			nation.get_child(1).modulate = Color( 0.8, 0.36, 0.36, 1 )
			# if a SINGLE ally stands, the game isn't over yet!
			allAllies = false
		else:
			nation.get_child(1).modulate = baseColor
	
		# keep the nation's unit count accurate
		nation.get_child(2).set_text(String(nation.units))

	if allAllies || allEnemies:
		emit_signal("victory")



# AHAHAHAHAHA
# This is it?!
# Holy shit man.
# okay, well, moving forward.
### NOTE-  this joke doesnt work now that ive moved the population
### stuff lmao
# think i'll turn this into my whole AI managment shit.
# could make this quite uh
# what was the word
# OFFLOAD
# gonna offload AI to this doc

# every turn, all nations produce 1 unit
func nextTurn():
	
	for nation in nations:
		
		# AI STUFF!
		# for each enemy nation, do some stuff!
		if nation.team == "Enemies":
			
			
			# delay his crazy fast moves!
			#print ("MWAH")
			#yield(get_tree().create_timer(1.0), "timeout")
			#print ("Hrm.")
			
			
			# if you only have one neighbor and its allied
			# dump all your units into it
			if nation.connectedNations.size() == 1 && getNationByName(nation.connectedNations[0]).team == "Enemies":
				#print ("SAFE", nation.connectedNations)
				var arrow = nationCollision.genArrow(getNationByName(nation.connectedNations[0]), nation, true)
				nextTurnButton.addAttack(getNationByName(nation.connectedNations[0]), nation, arrow)
	
			# otherwise, actually thunk
			# thinking process is simple!
			# the first neighboring province that has less troops
			# you invade!
			# if there are no hostile provinces
			# move all your units to the province with the most troops!
			
			# probabyl could elaborate later, like...
			# prioritize invading allies vs neutral
			# uhhh other stuff?
			else:
				var hostiles = false
				var biggestNeighbor
				
				for neighbor in nation.connectedNations:
					
					# if starting out, just assign
					# biggestNeighbor to first guy
					if biggestNeighbor == null:
						biggestNeighbor = neighbor
					# otherwise, check to see who's bigger,
					# then take them!
					else:
						if getNationByName(neighbor).units > getNationByName(biggestNeighbor).units:
							biggestNeighbor = neighbor
					
					if getNationByName(neighbor).team != "Enemies":
						hostiles = true
						if getNationByName(neighbor).units < nation.units:
							var arrow = nationCollision.genArrow(getNationByName(neighbor), nation, true)
							nextTurnButton.addAttack(getNationByName(neighbor), nation, arrow)
							
				
				# if you have no hostile neighbors,
				# send ur troops to the nation
				# with the most troops
				if hostiles == false:
					#print ("Safe")
					var arrow = nationCollision.genArrow(getNationByName(biggestNeighbor), nation, true)
					nextTurnButton.addAttack(getNationByName(biggestNeighbor), nation, arrow)
	
func populate():
	
	# give 'em a minute to process!
	yield(get_tree().create_timer(0.5), "timeout")
	
	# gotta do this seperate...AI is too fast...
	for nation in nations:
		nation.units += 1


# signal stuff?
func _on_NationAreas_clickedNation(_clickedNation):
	pass
	#print(clickedNation.name)
func _on_NextTurnButton_nextTurn():
	nextTurn()


# SHAMELESSLY STOLEN FROM NATIONCOLLISON
# god knows that file needs some relief.
# given a nation's name, return the nation's node
func getNationByName(nationName):
	for i in nations:
		if i.name == nationName:
			return i


func _on_NextTurnButton_repopulate():
	populate()
