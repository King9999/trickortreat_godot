"""
The Ghost has a trick that hits all other opponents in range, and makes them drop more candy than normal. However, the 
cooldown for their trick is longer than most.
"""
extends Costume

func _ready() -> void:
	super._ready()				#calls the _ready() function from parent node.
	#_set_default_candy_taken(1)
	
#TODO: add code for trick
func _set_default_candy_taken(amount: int):
	default_candy_taken = amount
	candy_taken = default_candy_taken
