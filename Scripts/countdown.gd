"""
Timer that ticks down to 0 before the game can start
"""

extends Node2D

class_name Countdown

@onready var countdown_label: RichTextLabel = $"Countdown Label"
@export var countdown_time: float
var counting_down: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#set_countdown_time(4)
	#await get_tree().create_timer(1).timeout
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if counting_down:
		if countdown_time > 1:
			countdown_time -= delta
			countdown_label.text = "%d" % countdown_time
		else:
			countdown_label.text = "GO!"
			await get_tree().create_timer(1).timeout
			visible = false							#hide self
			set_process(false)

func set_countdown_time(seconds: float):
	countdown_time = seconds
	#countdown_label.text = "%d" % countdown_time
func start_countdown(toggle: bool):
	counting_down = toggle
