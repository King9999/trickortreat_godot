"""
The Knight moves slower than other costumes, but has a fast recharging trick, and doesn't lose as much candy when hit.
"""
extends Costume

func _ready() -> void:
	_set_default_candy_taken(2)
	move_speed = BASE_MOVE_SPEED - 30
	candy_drop_amount = INIT_CANDY_DROP_AMOUNT - 3

func _set_default_candy_taken(amount: int):
	default_candy_taken = amount
	candy_taken = default_candy_taken
