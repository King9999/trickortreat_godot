"""
The Knight moves slower than other costumes, but has a fast recharging trick, and doesn't lose as much candy when hit.
"""
extends Costume

@onready var sword_slash: Area2D = $"Sword Slash"

func _ready() -> void:
	super._ready()			#calls the _ready() function from parent node.
	#set up parameters
	set_up_parameters(CostumeType.KNIGHT)
	sword_slash.enable_slash(false)


func _set_default_candy_taken(amount: int):
	default_candy_taken = amount
	candy_taken = default_candy_taken

func use_trick():
	if trick_active || trick_on_cooldown || stunned:
		return
	
	trick_active = true
	move_speed = 0				#knight can't move during trick
	#display sword slash 
	#print("slashing")
	sword_slash.enable_slash(true, direction_vector)
	await get_tree().create_timer(trick_duration).timeout
	sword_slash.enable_slash(false)
	move_speed = base_move_speed
	end_trick()
	#print("slash ended")
