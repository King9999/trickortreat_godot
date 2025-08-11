"""
The Princess has no special abilities, but gets double the amount of candy from houses. She is slightly faster than average.
"""

extends Costume

func _ready() -> void:
	super._ready()
	set_default_candy_taken(2)
	move_speed = BASE_MOVE_SPEED + 15
	
