"""
Handles all of the gameplay, including setting up the players, starting the game, and checking if the game is over.
"""

extends Node2D
class_name GameManager

@onready var timer: Game_Timer = $Timer
@onready var countdown: Countdown = $Countdown

#player start positions
@onready var player_position1: Node2D = $"Player 1 Start Position"
@onready var player_position2: Node2D = $"Player 2 Start Position"
@onready var player_position3: Node2D = $"Player 3 Start Position"
@onready var player_position4: Node2D = $"Player 4 Start Position"

#HUD
@onready var hud: GameHUD = $HUD

@export var candy_scene: PackedScene
@export var candy_list: Array[Candy] = []			#location of on screen candy objects
@export var game_time: int							#time in seconds. default 2 minutes
var game_started: bool

#costumes
@export var costume_scenes: Array[PackedScene] = []
@export var players: Array[Costume] = []

enum Human_Player { PLAYER_ONE, PLAYER_TWO }

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Timer setup
	timer.set_timer(game_time)
	countdown.set_countdown_time(4)
	countdown.start_game.connect(_start_game)
	
	######player setup######
	#set up the first 2 players
	_set_up_players(Singleton.costume_p1)
	_set_up_players(Singleton.costume_p2)
	
	#set up CPU opponents if any
	if Singleton.cpu_opponent_count == 1:
		_set_up_players(Singleton.rand_cpu_costume)
	elif Singleton.cpu_opponent_count == 2:
		for cpu_player in Singleton.cpu_costumes:
			_set_up_players(cpu_player)	
	
	#HUD set up
	hud.set_up_huds()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !game_started:
		countdown.start_countdown(true)
	else:
		#check if player used trick
		if Input.is_action_just_pressed("P1_Trick"):
			players[Human_Player.PLAYER_ONE].use_trick()
		if Input.is_action_just_pressed("P2_Trick"):
			players[Human_Player.PLAYER_TWO].use_trick()

#function executes when countdown emits signal
func _start_game():
	print("Starting game")
	game_started = true
	timer.start_timer(true)
	countdown.start_game.disconnect(_start_game)	#prevents code from running more than once
	

##Adds human-controlled 
func _set_up_players(selection: Singleton.Selection):
	match(selection):
		Singleton.Selection.GHOST:
			players.append(costume_scenes[Singleton.Selection.GHOST].instantiate())
		Singleton.Selection.KNIGHT:
			players.append(costume_scenes[Singleton.Selection.KNIGHT].instantiate())
		Singleton.Selection.PRINCESS:
			players.append(costume_scenes[Singleton.Selection.PRINCESS].instantiate())
		Singleton.Selection.WITCH:
			players.append(costume_scenes[Singleton.Selection.WITCH].instantiate())			
	
	#ensure the player is human-controlled.
	var player: Costume = players[players.size() - 1]
	#player.player_type = Costume.Player.HUMAN
	
	#set position and player type. Players 3 and 4 are always CPU opponents.
	if players.size() == 1:
		player.global_position = player_position1.global_position
		player.player_type = Costume.Player.HUMAN
		player.player_num = 0
	elif players.size() == 2:
		player.global_position = player_position2.global_position
		player.player_type = Costume.Player.HUMAN
		player.player_num = 1
	elif players.size() == 3:
		player.global_position = player_position3.global_position
		player.player_type = Costume.Player.CPU
		player.player_num = 2
	else:
		player.global_position = player_position4.global_position
		player.player_type = Costume.Player.CPU
		player.player_num = 3
			
	add_child(player) #important step when instantiating nodes.

func _set_up_cpu_players():
	pass

#reads input from keyboard/controller
func _physics_process(delta: float) -> void:
	if game_started:
		var input_p1 = Input.get_vector(Singleton.left_p1, Singleton.right_p1, Singleton.up_p1, Singleton.down_p1)
		var input_p2 = Input.get_vector(Singleton.left_p2, Singleton.right_p2, Singleton.up_p2, Singleton.down_p2)
		
		#get direction. Even if input is released we still have the last input entered, so any tricks that depend on direction
		#will fire in correct direction.
		var player_1 = players[Human_Player.PLAYER_ONE]
		var player_2 = players[Human_Player.PLAYER_TWO]
		
		if (input_p1.x != 0 or input_p1.y != 0):
			player_1.direction_vector = input_p1
			#print("Direction Vector P1: {0}".format([players[Human_Player.PLAYER_ONE].direction_vector]))
		if (input_p2.x != 0 or input_p2.y != 0):
			player_2.direction_vector = input_p2
			#print("Direction Vector P2: {0}".format([players[Human_Player.PLAYER_TWO].direction_vector]))
		
		player_1.global_position += input_p1 * delta * player_1.move_speed
		player_2.global_position += input_p2 * delta * player_2.move_speed
		
		player_1.move_and_slide()
		player_2.move_and_slide()
