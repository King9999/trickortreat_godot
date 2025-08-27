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
	if trick_active || trick_on_cooldown || stunned:
		return
	
	trick_active = true
	move_speed = 0				#Ghost can't move during trick
	#display BOO
	print("BOO!")
	boo_attack.enable_boo(true)
	await get_tree().create_timer(trick_duration).timeout
	boo_attack.enable_boo(false)
	move_speed = base_move_speed
	end_trick()
	print("boo ended")
