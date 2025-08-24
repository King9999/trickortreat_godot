"""
Contains behaviours for AI-controlled players. Behaviour works as follows:
	1. CPU begins by searching for houses with candy. They look for a house with the most candy.
	2. If at any point another player enters the CPU's range, the CPU attacks them if they have candy.
"""

extends Node2D
class_name PlayerAI

@onready var player: Costume = get_parent()
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D		#used to move CPU players
enum State { IDLE, HOUSE_SEARCH, COLLECTING_CANDY, ATTACKING_PLAYER, PICK_UP_DROPPED_CANDY }
var player_state: State
@export var target_player: Costume				#the enemy player currently being pursued/attacked
@export var target_house: House
@export var detect_range: float = 200
@export var detect_rate: float = 0.2		#the rate at which the CPU searches for players or candy

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

func _physics_process(delta: float) -> void:
	if player.player_type == Costume.Player.HUMAN:
		return
		
	#movement check
	if !nav_agent.is_navigation_finished():
		_move(player, delta)
		

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
			
			#once house is found, move towards the house's trigger
			nav_agent.target_position = Vector2(target_house.candy_pickup_area.global_position.x, target_house.candy_pickup_area.global_position.y \
				+ target_house.candy_pickup_area.shape.get_rect().size.y / 1.5)
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
			
	
