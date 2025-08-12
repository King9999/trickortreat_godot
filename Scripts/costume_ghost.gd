"""
The Ghost has a trick that hits all other opponents in range, and makes them drop more candy than normal. However, the 
cooldown for their trick is longer than most.
"""
extends Costume
@onready var boo_attack: Area2D = $Boo

func _ready() -> void:
	super._ready()				#calls the _ready() function from parent node.
	#_set_default_candy_taken(1)
	boo_attack.enable_boo(false)
	
#TODO: add code for trick
func _set_default_candy_taken(amount: int):
	default_candy_taken = amount
	candy_taken = default_candy_taken

func use_trick():
	#When trick is used, ghost's hitbox must be temporarily disabled so they aren't hit by their own attack
	pass
