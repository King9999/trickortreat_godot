"""
The Ghost has a trick that hits all other opponents in range, and makes them drop more candy than normal. However, the 
cooldown for their trick is longer than most.
"""
extends Costume
@onready var boo_attack: Area2D = $Boo

func _ready() -> void:
	super._ready()				#calls the _ready() function from parent node.
	#set up parameters
	set_up_parameters(CostumeType.GHOST)
	boo_attack.enable_boo(false)

		
#TODO: add code for trick
func _set_default_candy_taken(amount: int):
	default_candy_taken = amount
	candy_taken = default_candy_taken

#Generates a "BOO" sprite. Any target in range of it drops double candy.
func use_trick():
	#When trick is used, ghost's hitbox must be temporarily disabled so they aren't hit by their own attack
	pass
