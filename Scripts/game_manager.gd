"""
Handles all of the gameplay, including setting up the players, starting the game, and checking if the game is over.
"""

extends Node2D

@onready var timer: Game_Timer = $Timer
@onready var countdown: Countdown = $Countdown

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.set_timer(120)
	countdown.set_countdown_time(4)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
