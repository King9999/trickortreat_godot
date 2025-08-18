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
	pass
	
