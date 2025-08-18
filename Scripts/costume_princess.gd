"""
The Princess has no special abilities, but gets double the amount of candy from houses. She is slightly faster than average.
"""

extends Costume

@onready var question_mark: Sprite2D = $"Question Mark"

func _ready() -> void:
	super._ready()
	#set up parameters
	set_up_parameters(CostumeType.PRINCESS)
	question_mark.visible = false

		
func use_trick():
	question_mark.visible = true
	await get_tree().create_timer(2).timeout
	question_mark.visible = false

#func _move(delta: float):
	#var input = Input.get_vector("Left", "Right", "Up", "Down")
	#global_position = input * delta * move_speed
