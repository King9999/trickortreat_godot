"""
The Knight moves slower than other costumes, but has a fast recharging trick, and doesn't lose as much candy when hit.
"""
extends Costume

func _ready() -> void:
	move_speed = BASE_MOVE_SPEED - 30
	candy_drop_amount = INIT_CANDY_DROP_AMOUNT - 3
