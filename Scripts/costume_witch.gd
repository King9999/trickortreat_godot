"""
The witch has a long-range trick that can hit another player from a distance. The projectile also pierces, which means 
it can hit multiple targets until it collides with a house or goes off screen. The witch is slightly slower than average,
but not as slow as the Knight. The witch's magic shot isn't immediately available at the start of the game.
"""

extends Costume

@onready var magic_shot : Area2D = $"Magic Shot"

func _ready() -> void:
	super._ready()
	move_speed = BASE_MOVE_SPEED - 15
	magic_shot.enable_magic_shot(false) 			#disables the node until it's ready to be used.
	#use_trick()

func use_trick():
	magic_shot.enable_magic_shot(true)
