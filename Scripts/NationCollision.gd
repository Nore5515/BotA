extends Area2D


signal clickedNation (nationNumber)

onready var nations = get_tree().get_nodes_in_group("Nation")

# get the base nation color
onready var baseColor = nations[0].get_child(0).modulate

# get the attack arrow model
onready var arrowModel = get_tree().get_nodes_in_group("arrow")[0]
# instanced arrow
onready var arrow
# also the attack arrow's base scale...for returning to normal
# from stretchy :)
onready var arrowScale = arrowModel.get_scale()

# PLEASE OFFLOAD SHIT TO THIS OH MY GOD THIS DOCUMENT IS SO LONG
onready var nextTurnButton = get_tree().get_nodes_in_group("nextTurn")[0]

# Unit Count slider for transfering!
onready var unitSlider = get_tree().get_nodes_in_group("unitSlider")[0]

# double click unit transfer!
var doubleClickTransfer = false

# to deselect.
var clickedNationName = ""

# to tell the arrow if you're attacking
var attacking = false

# node of the attacked nation, to place the arrow on
var attackedNation

# units you are attacking with. Will be painted
# on arrow.
var attackingUnits

# if true, then it'll deselect things instead of color them.
var deselected = false

# a flag, to tell if you're building or just moving units around.
var building = false

func _input_event(_viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		self.on_click(shape_idx) 



func on_click(nationNum):
	
	deselected = false
	attacking = false
	
	# Get's the nation that was clicked
	var nation = self.get_child(nationNum)
	# if it's one of the _ nations, then just get the base nation.
	var temp = 1
	while "_" in nation.name:
		nation = self.get_child(nationNum-temp)
		temp += 1
	
	
	
	# If you've clicked on a nation that's currently connected to your selected nation
	# AND you're going from allied to non-allied
	#that's an attack!
	
	# during an attack, you send ALL of your units.
	# you subtract units from both sides equally.
	# if you have more than 0, than you won! all remaining units move up.
	# if you have 0 or less, then you lost...nothing happens.

	# if you already have a nation selected
	# AND if you're not speed transferring
	if getNationByName(clickedNationName) != null && doubleClickTransfer == false:
		
		
		# If you ARE building...
		if building:
			# if you are selecting an allied territory
			if getNationByName(clickedNationName).team == "Allies":
				getNationByName(clickedNationName).addFactories(1)
		
		# If you are NOT building...
		elif !building:
			# if you are selecting an allied territory
			if getNationByName(clickedNationName).team == "Allies":
				
				# and clicking on the same territory again!
				if getNationByName(clickedNationName).name == nation.name:
					print ("WAH")
				
				
				# AND clicking an enemy territory
				if nation.get_child(0).modulate == Color(0.55, 0, 0, 1):
					#print ("attacking!")
					
					# THEN YOU ATTACK!
					
					attacking = true
					attackedNation = nation
					attackingUnits = getNationByName(clickedNationName).units
					
					# In an effort to offload stuff from this doc...
					# I'm gonna try and have the next turn button
					# queue up unit attack commands.
					# aka, when u try to attack someone it records
					# that attack, then commits all attacks
					# when the button is pressed
					
					# pass the button the nation you're attacking!
					# it will add them to a list.
					# that's all for now.
					# okay! that works! now for more...
					# make it so that attacks are now handled 
					# ENTIRELY by the button!
					# GL...
					# DONE!
					# Damn, i'm on a roll.
					# I'll continue this actually IN that script.
					#nextTurnButton.addAttack(attackedNation, getNationByName(clickedNationName))
					
					# Okay, I'm back!
					# That was fun. Queued attacks!
					# Now we need a way to dupe arrows
					# and, more importantly
					# have attacking units on the arrows
					# AND PREVENT YOU FROM ATTACKING SAME PLACE TWICE FROM SAME PLACE
					# ok ok plan...think...
					# i think a first ez step would be to add attacking unit count
					# onto the attack arrow.
					# See you down in arrow town.
					# huh, that was easier than i thought.
					# now is the hard part.
					# DUPING ARROWS
					# sigh, to google...
					# wow, that was NOT that hard!
					# okay, lets uhhh
					# OH LETS PASS THE ATTACCK ARROW INTO THE ATTACK
					# HOOOOOOLY SHIT 
					# ok wow i'm gonna need to scootch this WAAAY down.
					# when you're reading through this again, 
					# and you see the main line commented out,
					# just go check down by the arrow shit ;)
					
					# okay, back!
					# that was...interesting.
					# but successful!
					# now i wanna add...
					# ENEMY AI
					# BWUM BWUM BWUMMMM
					# also if i hear "not one less"
					# in my friggin playlist
					# im gonna scream
					# great song
					# but AAAAAAAAAAAAAAAAAAAA
					# 50 TIMES
					# 50 TIMES TOO MANY
					# anyways. Enemy AI.
					# i think a first ez step is just to create
					# an enemy team, and paint 'em red
					# ok! Done.
					# now, i think...
					# yes, Nations should handl e
					# oops mom just texted
					# sneezed too hard :\
					# nations.gd, you're for tomorrow.
					# you'll handle AI soon enough.
					
					# Okay i lied i kept going
					# lol
					# AI exists, and is terrifying
					# mostly because he moves SO FAST you cant tell what hes doing!
					# gonna create a like
					# delay
					# so it slowly ticks off his actions
					# ALSO i made the arrow thing into a function!
					# owo
					# that was supposed to be woo
				
				
				# THIS ALSO FLAGS IF YOU'RE JUST 
				# CLICKING ALLIED TERRITORY AFTER
				# SELECTING NOTHING
				# if you're just clicking your allied territory
				# and NOT deselecting lol [this eradicated your troops]
				# you move troops around.
				else:
					if nation.name == clickedNationName:
						pass
					else:
						# transfer to ADJACENT allied, deselect on other
						#if nation.team == "Allies":
						if nation.get_child(0).modulate == Color( 0.12, 0.56, 1, 1 ):
							
							doubleClickTransfer = true
							#print ("transfering!!!")
							# By offloading this, we can adjust how we transfer!
							unitSlider.processTransfer(nation, getNationByName(clickedNationName))
						else:
							pass
						
						
			# deselect afterwards.
			deselected = true
	
	else:
		print ("SELECTING CLICK")
	
	# RUN ARROW FUNC ONLY IF U HAVE UNITS
	if getNationByName(clickedNationName) != null:
		if getNationByName(clickedNationName).units > 0:
			genArrow(attackedNation, getNationByName(clickedNationName), attacking)
	
	
	# reset all nation's colors to the initial base color of ~~the first nation~~.
	# THEIR TEAM
	# haha update B)
	# wiast waht
	# jeez nevermind its in "Nations.gd" for god knows why
	# lmao
	for nat in nations:
		
		nat.get_child(0).modulate = baseColor
	
	
	# if you double clicked, deselect EVERYTHING. Otherwise, as normal.
	if nation.name == clickedNationName || deselected:
		clickedNationName = ""
	
	# if you're speed double click transferring, ignore below!
	elif doubleClickTransfer:
		print ("speed transfer!")
		unitSlider.speedTransfer()
		doubleClickTransfer = false
	
	else:
		
		# select the currently clicked nation.
		# if allied, paint it green. #otherwise, yello
		if nation.team == "Allies":
			nation.get_child(0).modulate = Color( 0, 1, 0, 1 )
		else:
			nation.get_child(0).modulate = Color( 1, 0.84, 0, 1 )
		
		# in the clicked nation, for all connectedNation's names...
		for nationName in nation.connectedNations:
		
			# try and get the nation by name. If it exists...
			if getNationByName(nationName) != null:
				# check if it's already glowy. If it's already glowy, unglowy it.
				if getNationByName(nationName).get_child(0).modulate != baseColor:
					getNationByName(nationName).get_child(0).modulate = baseColor
				else:
					# if it's allied, make it blue glowy.
					if getNationByName(nationName).team == "Allies":
						getNationByName(nationName).get_child(0).modulate = Color( 0.12, 0.56, 1, 1 )
					# otherwise, make it red glowy.
					else:
						getNationByName(nationName).get_child(0).modulate = Color(0.55, 0, 0, 1)
			
			#print (">", nationName)
			
		# This handles double clicking the same nation to deselct it.
		clickedNationName = nation.name
	
	
	
	emit_signal("clickedNation", nation)

# given a nation's name, return the nation's node
func getNationByName(nationName):
	for i in nations:
		if i.name == nationName:
			return i
			


# God help me.
# Oh. That was easy.
# OH NO WHAT VARIABLES MATTER
func genArrow(defendingNation, attackingNation, attacking):
	
	###########################
	### TESTING ARROW STUFF ###
	###########################
	
	# I'm gonna try to function this whole thing.
	# wish me luck.

	# place the arrow onto whatever nation you're attacking
	# otherwise, hide the arrow.
	
	# if the nation exists AND if attacking...
	if defendingNation != null && attacking:
		
		# make a new arrow, based on the saved model.
		var packedArrow = load("res://arrow.tscn")
		arrow = packedArrow.instance()
		add_child(arrow)
		
		# make it visible, and place it 			~~on the base nation~~.
		# place it BETWEEN the two nations.
		arrow.visible = true
		arrow.set_position((attackingNation.get_position()+defendingNation.get_position())/2)
		
		# Then, update the arrow's unit label with 
		# the current number of attacking units.
		arrow.get_child(0).text = String(attackingNation.units)
		
		# get the vector2 of the distance between dest and current.
		# this will give us a vector2 we can add to our current
		# to get our dest. we can use this to scale proper.
		var diff = defendingNation.get_position() - attackingNation.get_position()
		
		# reset arrow rotaation, then
		# rotate the arrow, so that it's pointing the right way.
		arrow.set_rotation(0)
		
		#print ("Start Vector>", getNationByName(clickedNationName).get_position(), "<End Vector>",attackedNation.get_position())
		var startVector = attackingNation.get_position()
		var endVector = defendingNation.get_position()
		var diffVector = endVector - startVector
		var unitVector = diffVector / (diffVector.length())
		var thetaMod = 0 # what to add to theta!
		
		if diffVector.x < 0:
			if diffVector.y > 0:
				#print ("QUADRANT II")
				thetaMod = PI
			else:
				#print ("QUADRANT III")
				thetaMod = -PI
		else:
			if diffVector.y > 0:
				pass
				#print ("QUADRANT I")
			else:
				pass
				#print ("QUADRANT IV")
				#thetaMod = (3*PI)/2
		
		var yDist = (endVector.y-startVector.y)
		var xDist = (endVector.x-startVector.x)
		var angleDiff = yDist/xDist
		# The angle from the center beam to the point
		# IN RADIANS
		var theta = atan(angleDiff) + thetaMod
		
		
		#print ("Y Distance>", yDist, "X Distance>", xDist)
		#print ("DIFF>", yDist/xDist)
		#print ("THETA>", theta)
		#print ("THETA, but in Degrees>", theta * (180/PI))
		
		# gets the angle from selected nation to attacking nation
		# in RADIANS.
		#var theta = (atan((attackedNation.get_position().y-getNationByName(clickedNationName).get_position().y)/(attackedNation.get_position().x-getNationByName(clickedNationName).get_position().x)))
		
		
		arrow.set_rotation(theta)
		#print ("FINAL ROT>", arrow.get_rotation())
		
		# now to adjust it to proportions by dividing it by the destination.
		#diff = Vector2(diff.x/attackedNation.get_position().x, diff.y/attackedNation.get_position().y)
		
		# reset the arrow's stretchy
		arrow.set_scale(arrowScale)
		
		# minimum arrow scales!
		var minX = 0.05
		var minY = 0.05
		
		# Trying this...
		# multiply its scale by the difference in the points.
		# in hindsight, i see why this wont work.
		# but i wanna see it anyways :)
		var scale = arrow.get_scale()
		#print (scale)
		#unitVector.x = unitVector.x * 0.8
		#unitVector = unitVector * 0.3
		scale.x = scale.x * -1 * (unitVector.x + unitVector.x)
		scale.y = scale.y * -1 * (unitVector.y + unitVector.y)
		if scale.x < minX:
			scale.x = minX
		if scale.y < minY:
			scale.y = minY
		arrow.set_scale(scale)

	else:
		if (arrow != null):
			#arrow.visible = false
			pass
		#pass
	
	
	# starting anew here!
	# gonna try passing each attack its own attack arrow!
	if (attacking):
		nextTurnButton.addAttack(defendingNation, attackingNation, arrow)
	
	return arrow
	###############################
	### END TESTING ARROW STUFF ###
	###############################
