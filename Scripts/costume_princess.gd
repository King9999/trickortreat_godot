"""
The Princess has no special abilities, but gets double the amount of candy from houses.
"""

extends Costume

func _ready() -> void:
	super._ready()
	set_default_candy_taken(2)
	
