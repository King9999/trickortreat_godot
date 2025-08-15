"""
Handles all of the gameplay, including setting up the players, starting the game, and checking if the game is over.
"""

extends Node2D

@onready var timer: Game_Timer = $Timer
@onready var countdown: Countdown = $Countdown

#player start positions
@onready var player_position1: Node2D = $"Player 1 Start Position"
@onready var player_position2: Node2D = $"Player 2 Start Position"
@onready var player_position3: Node2D = $"Player 3 Start Position"
@onready var player_position4: Node2D = $"Player 4 Start Position"

@export var candy_list: Array[Candy] = []			#location of on screen candy objects
@export var game_time: int							#time in seconds. default 2 minutes
var game_started: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Timer setup
	timer.set_timer(game_time)
	countdown.set_countdown_time(4)
	countdown.start_game.connect(_start_game)
	
	######player setup######
	#set up the first 2 players
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !game_started:
		countdown.start_countdown(true)
	else:
		pass

#function executes when countdown emits signal
func _start_game():
	print("Starting game")
	game_started = true
	timer.start_timer(true)
	countdown.start_game.disconnect(_start_game)	#prevents code from running more than once
