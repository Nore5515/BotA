extends Button


signal nextTurn()
signal repopulate()

var attacks


### HYPER TEMP
onready var nations = get_tree().get_nodes_in_group("Nation")

# timer, for slowing the turns down
#onready var timer = get_tree().get_nodes_in_group("timer")[0]

# in case u need to skip the normal attack
# cus someone was just adding to another attack
var dupedAttack


# Called when the node enters the scene tree for the first time.
func _ready():
	attacks = []


# thaaat's better!
# man, offloading feels good.
# look how clean this doc is!!!
# hehehe. time to tarnish it.
# lets make it so that whenever you attack, you add it to a queue.
# not saiyng we stop the attack, but we dupe it into a queue.
# hahaHA!
# alright!! JSON format, babeEEEE
# now lets see...
# lets make it so that hitting the play button runs ALL attacks through
# then disable the defautl attacking method!
# here we go...
# WOO HOO!
# Oh BABY
# ThATS WHAT IM TALKIN ABOUT
# okay okay
# lets finish off strong
# whenever u attack, remove the units from the attacking nation
# that way u cant transfer-forever attack
# WOWZA
# That.
# Was badass.
# Now it's time to mess with the arrows!
func addAttack(defendingNation, attackingNation, atkArrow):
	
	dupedAttack = false
	
	# first, check to see if an attack is already underway
	# from the same province INTO the same province.
	# if so, just add it to the current attack.
	
	# turns out that is much harder than i thought
	# but i may have solved two birds with one 
	# uh
	# digital rock
	# i added each atk arrow to the attacks
	# meaning i can modify them freely
	# perhaps even erase each one slowly, one at a time
	# :)
	# AND NO ITS NOT WAARZONE SHUT UP SHUT UP SHUT UP
	
	# also just ignore 0 unit attack provinces
	
	if attacks.size() > 0 && attackingNation.units > 0:
		for atk in attacks:
			print ((atk["Attacker"])["Name"]," =? ", attackingNation.name)
			if ((atk["Attacker"])["Name"] == attackingNation.name):
				if ((atk["Defender"])["Name"] == defendingNation.name):
					# add the units to the queued attack...
					# then update the arrow...
					# then uh.
					# oh remove the units
					print ("DUPED",atk["AttackArrow"].get_child(0).text)
					(atk["Attacker"])["Units"] += attackingNation.units
					atk["AttackArrow"].get_child(0).text = String((atk["Attacker"])["Units"])
					dupedAttack = true
					#print ("wagh",atk["AttackArrow"].get_child(0).text)
					atkArrow.queue_free()
	
	if (!dupedAttack) && attackingNation.units > 0:
		# add a copy of the attack into attacks!
		attacks.append(
		{
			"Defender": {
				"Role": "Defender",
				"Name": defendingNation.name,
				"Units": defendingNation.units,
				"Team": defendingNation.team,
				"Node": defendingNation
			},
			"Attacker": {
				# are these roles excessive?
				"Role": "Attacker",
				"Name": attackingNation.name,
				"Units": attackingNation.units,
				"Team": attackingNation.team,
				"Node": attackingNation
			},
			"AttackArrow":atkArrow
		})
	
	attackingNation.units = 0




func _on_NextTurnButton_pressed():
	
	# it'll hand off to Nations, who will handle AI.
	# it will finish before this moves on.
	emit_signal("nextTurn")
	
	#print (attacks)
	
	var attacker
	var defender
	
	#for nation in nations:
	#	print (nation.name, ">", nation.units)
	
	for atk in attacks:
		
		# DELAY PER ATTACK!
		#print (atk)
		#print ("MWAH")
		yield(get_tree().create_timer(0.5), "timeout")
		#print ("Hrm.")
		
		attacker = atk["Attacker"]
		defender = atk["Defender"]
		
		# IF TERRITORY IS ALREADY CAPTURED
		# JUST ADD YOUR UNITS THERE
		# hehe i modified it so instead of
		# always allies
		# now its just whoever's attacking team
		# :)
		#print ("Defender>",defender["Node"].team,"<CurrentAttacker>",attacker["Node"].team,"<PlannedAttacker>",attacker["Team"])
		#if (defender["Node"].team == attacker["Node"].team):
		# Check to see if you've broken someone's plans!
		if (attacker["Node"].team != attacker["Team"]):
			print ("Assault Broken!")
		else:
			if (defender["Node"].team == attacker["Team"]):
				defender["Node"].units += attacker["Units"]
				#attacker["Node"].units -= attacker["Units"]
				print ("Transfer complete!")
			# Otherwise, attack as normal! Victory con here.
			elif (attacker["Units"] > defender["Node"].units):
				defender["Node"].units = attacker["Units"] - defender["Units"]
				#attacker["Node"].units -= attacker["Units"]
				defender["Node"].team = attacker["Node"].team
				print ("Victory!")
			# Defeat con :[
			else:
				defender["Node"].units -= attacker["Units"]
				#attacker["Node"].units -= attacker["Units"]
				print ("Defeat...")
	
		atk["AttackArrow"].queue_free()
	
	# free up attacks array
	attacks = []
	
	
	
	# CORRECTION!
	# going to rmeove them as we go. this is outdated.
	# Now it's time to clear out all those attack arrows!
	#var arrows = get_tree().get_nodes_in_group("arrow")
	# we'll go through each one and free them.
	# "Free"
	#for argh in arrows:
	#	argh.queue_free()
		
	
	# safe from the AI, we can repopulate!
	emit_signal("repopulate")
	
	
	
