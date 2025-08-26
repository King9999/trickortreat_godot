"""
Contains behaviours for AI-controlled players. Behaviour works as follows:
	1. CPU begins by searching for houses with candy. They look for a house with the most candy.
	2. If at any point another player enters the CPU's range, the CPU attacks them if they have candy.
"""

extends Node2D
class_name PlayerAI

signal house_empty()				#when a house runs out of candy, alerts CPU to move on to next house.

@onready var player: Costume = get_parent()
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D		#used to move CPU players
enum State { IDLE, HOUSE_SEARCH, COLLECTING_CANDY, ATTACKING_PLAYER, PICK_UP_DROPPED_CANDY }
@export var player_state: State
@export var target_player: Costume				#the enemy player currently being pursued/attacked
@export var target_house: House
#@export var detect_range: float = 200
#@export var attack_range: float = 30		#minimum distance in pixels for the CPU to hit enemy player with trick. Witch has highest range
@export var detect_rate: float = 0.2		#the rate at which the CPU searches for players or candy
var last_detect_time: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#player_state = State.HOUSE_SEARCH
	#player.player_type = Costume.Player.CPU
	#print(house_manager.name)
	#player.enable_ai.connect(toggle_ai)
	if player.player_type == Costume.Player.HUMAN:
		return
		
	#_change_state(State.IDLE)


func _process(delta: float) -> void:
	if player.player_type == Costume.Player.HUMAN:
		return
	
	if !Singleton.game_manager.game_started:
		player_state = State.IDLE
		return
	#movement check
	#if !nav_agent.is_navigation_finished():
		#_move(player, delta)
	
	#search for houses after game starts
	if player_state == State.IDLE:
		_change_state(State.HOUSE_SEARCH)
	
	if _house_out_of_candy(target_house):
		pass

func _physics_process(delta: float) -> void:
	if player.player_type == Costume.Player.HUMAN:
		return
		
	#movement check
	if !nav_agent.is_navigation_finished():
		_move(player, delta)
		
		#check for enemy players along the way. 
		#If player is in range, stop targetting house and target player instead.
		#Princess never targets other players
		var time = Time.get_unix_time_from_system()
		if time > last_detect_time + detect_rate:
			var i = 0
			var target_found: bool = false
			while !target_found && i < Singleton.game_manager.players.size():
				if Singleton.game_manager.players[i] == player:		#don't want to target self
					i += 1
					continue
					
				var distance = player.global_position.distance_to(Singleton.game_manager.players[i].global_position)
				if distance <= player.detect_range:
					#player is close, pursue
					set_target_player(Singleton.game_manager.players[i])
					#target_player = Singleton.game_manager.players[i]
					#target_house = null
					player_state = State.ATTACKING_PLAYER
					target_found = true
					print("target found")
				else:
					i += 1
	else:
		#if we're at house, change state
		if target_house != null && target_house.player_at_house:
			if target_house.candy_amount > 0:
				player_state = State.COLLECTING_CANDY
			else:
				player_state = State.IDLE
		  
		

func _change_state(state: State):
	player_state = state
	match(state):
		State.HOUSE_SEARCH:
			#check all houses and get the one with the most candy
			var house_manager = Singleton.house_manager
			target_house = house_manager.houses[0]
			for i in range(1, house_manager.houses.size()):		#if I want i to start from non-zero, must use range
				if house_manager.houses[i].candy_amount <= 0:
					continue
					
				if house_manager.houses[i].candy_amount > target_house.candy_amount:
					target_house = house_manager.houses[i]
			
			#once house is found, move towards the house's trigger. I divide the Y value so that the CPU doesn't clip through the house.
			#if !target_house.has_connections("on_house_empty"):
				#target_house.on_house_empty.connect(go_idle()) #TODO: Signal not working
			
			set_target_house(target_house)
			#nav_agent.target_position = Vector2(target_house.candy_pickup_area.global_position.x, target_house.candy_pickup_area.global_position.y \
				#+ target_house.candy_pickup_area.shape.get_rect().size.y / 1.5)
			print("{0}'s target house pos: {1}".format([player.costume_name, nav_agent.target_position]))

func toggle_ai(toggle: bool):
	if toggle == false:
		process_mode = Node.PROCESS_MODE_DISABLED	#must use this to completely disable a node instead of set_process
	else:
		process_mode = Node.PROCESS_MODE_ALWAYS

func _move(player: Costume, delta: float):
	var move_pos = nav_agent.get_next_path_position()
	var move_dir = player.global_position.direction_to(move_pos)
	var movement = move_dir * player.move_speed * delta
	player.translate(movement)

func _house_out_of_candy(house: House) -> bool:
	return player_state == State.COLLECTING_CANDY && house.candy_amount <= 0

func go_idle():
	print("ping!")
	player_state = State.IDLE

func set_target_house(house: House):
	target_house = house
	nav_agent.target_position = Vector2(house.candy_pickup_area.global_position.x, house.candy_pickup_area.global_position.y \
				+ house.candy_pickup_area.shape.get_rect().size.y / 1.5)
	target_player = null

func set_target_player(player: Costume):
	nav_agent.target_position = player.global_position
	target_house = null
	target_player = player
 
			
	
