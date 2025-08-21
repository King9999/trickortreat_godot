"""
Player controls. Can move in 8 directions, and execute a trick when it's available.

"""
extends CharacterBody2D
class_name Costume

signal on_hit(player: Costume)				#player sprite will shake and flash when hit by a trick. The appropriate funcs will be called
signal activate_trick_cooldown(player_num: int)			#picked up by HUD to show cooldown bar and to start cooldown
#@onready var hud: GameHUD = $HUD
@onready var sprite: Sprite2D = $Sprite_Costume

@export var costume_name: String
@export var candy_amount: int
@export var candy_drop_amount: int = 5      # how much candy the player drops when hit. 5 is the default.
@export var candy_taken: int = 1;           #how much candy the player gets from a house per tick
@export var default_candy_taken: int		#the princess takes more candy
var vx: float
var vy: float
@export var move_speed: float        #scales vx and vy. Lower value = slower speed
var base_move_speed: float
@export var direction_vector: Vector2				#tracks which way player is facing.

@export_category("Timers & Booleans")
var last_invul_time: float             			#timestamp to get current time
@export var invul_duration: float = 1.5       	#time in seconds. Determines how long player is invincible
@export var invincible: bool
var last_stun_time: float
@export var stun_duration: float = 0.7          #time in seconds. Player can't move during this time
@export var stunned: bool
@export var collecting_candy: bool			#is true when player is in front of house with candy
@export var trick_duration: float            #how long a trick is active for.
var last_cooldown_time: float           	#time in seconds before trick is recharged. Starts at zero so that trick can be used immediately at game start
@export var trick_cooldown: float           #cooldown of each trick.
var trick_active: bool
var trick_on_cooldown: bool
var last_hit_check_time: float				#checks for when player is hit to emit signal.

@onready var trick_or_treat_sprite: Sprite2D = $"Sprite_Trick Or Treat Bubble"

enum Player { HUMAN, CPU }
@export var player_type: Player
var player_num: int							#corresponds to the player_huds array hud.gd

enum CostumeType { GHOST, KNIGHT, PRINCESS, WITCH }   #used for identifying & extracting parameters in parameters.json
enum Direction { LEFT, RIGHT, UP, DOWN }				#used when tricks are activated so they can be launched in the direction player is facing.
@export var direction: Direction

#candy-specific variables
#var throw_candy: bool
#var candy_destinations: Array[Vector2] = []				#contains locations of where newly instantiated candy will be thrown

#consts  
const MAX_CANDY: int = 999
const INIT_CANDY_DROP_AMOUNT: int = 5
const BASE_MOVE_SPEED: float = 150

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	trick_or_treat_sprite.visible = false
	#set_default_candy_taken(1)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#_move(delta)
	#var time = Time.get_unix_time_from_system()
	#if time > last_hit_check_time + 0.2:
		#last_hit_check_time = time
		#on_hit.emit(self)
	"""if throw_candy == true:
		var game_manager:GameManager = get_parent()
		for i in candy_destinations.size():
			#get the latest new candy from candy list by counting backwards in array
			var candy = game_manager.candy_list[candy_destinations.size() - (i + 1)]
			var candy_dir: Vector2 = candy.global_position - self.global_position
			var destination: Vector2 = candy.global_position
			
			#move candy from player's position to destination. Hitbox is temporarily disabled so that candy isn't taken by player
			candy.hitbox.disabled = true
			candy.global_position = self.global_position
			candy.global_position.move_toward(destination, delta * 5)"""
			
	pass

#overridable function that will be used in inherhited nodes.	
func use_trick() -> void:
	pass
	
#func _move(delta: float):
	#var input = Input.get_vector("Left", "Right", "Up", "Down")
	#global_position += input * delta * move_speed
	

#TODO: Add this function in the candy script!	
#func add_candy(amount: int):
	#if candy_amount + amount <= MAX_CANDY:
		#candy_amount += amount
	
func drop_candy(amount: int):
	#Can't drop more candy than player has
	if candy_amount < amount:
		amount = candy_amount
	candy_amount -= amount
	#TODO: generate candy on screen for other players to pick up
	if amount <= 0:
		return
		
	var game_manager: GameManager = get_parent()
	for i in amount:
		#candy is sent to random positions around the player who got hit.
		var candy: Candy = game_manager.candy_scene.instantiate()
		var range: float = 50						#range is in pixels
		var rand_x = randf_range(-range, range)
		var rand_y = randf_range(-range, range)
		
		candy.global_position = Vector2(global_position.x + rand_x, global_position.y + rand_y)
		var vec_length = (candy.global_position - global_position).length()
		print("Vector length: {0}".format([vec_length]))
		while vec_length < 10:
			rand_x = randf_range(-range, range)
			rand_y = randf_range(-range, range)
			candy.global_position = Vector2(global_position.x + rand_x, global_position.y + rand_y)
		
		#candy flies out of player
		#candy_destinations.append(candy.global_position)
			
		game_manager.add_child(candy)
		game_manager.candy_list.append(candy)
	
	#throw candy
	#throw_candy = true

func set_default_candy_taken(amount: int):
	default_candy_taken = amount
	candy_taken = default_candy_taken

## Used when a player approaches a house to collect candy.	
func call_trick_or_treat(toggle: bool):
	trick_or_treat_sprite.visible = toggle

##Begins trick cooldown and emits signal to the HUD to display cooldown bar.	
func end_trick():
	trick_active = false
	last_cooldown_time = Time.get_unix_time_from_system()
	trick_on_cooldown = true
	
	var game_manager: GameManager = get_parent()
	#if (hud == null):
	#	hud = $HUD
	#game_manager.hud._activate_cooldown_bar(player_num)
	activate_trick_cooldown.emit(player_num)

##Applies parameters from JSON file	
func set_up_parameters(costume: CostumeType):
	costume_name = Singleton.json_param[costume].costume_name
	candy_drop_amount = Singleton.json_param[costume].candy_drop_amount
	candy_taken = Singleton.json_param[costume].candy_taken
	base_move_speed = Singleton.json_param[costume].move_speed
	move_speed = base_move_speed
	trick_cooldown = Singleton.json_param[costume].trick_cooldown
	trick_duration = Singleton.json_param[costume].trick_duration
	set_default_candy_taken(candy_taken)

##Causes player to shake and be stunned for a duration.
func take_hit():
	if invincible || stunned:
		return
	
	stunned = true
	invincible = true
	move_speed = 0
	var orig_pos: Vector2 = global_position
	
	#temporarily disable hitbox so player can't be hit by other opponents
	var hitbox:CollisionShape2D = $Collison
	hitbox.disabled = true
	
	#shake effect
	var y_pos: float = 4
	last_stun_time = Time.get_unix_time_from_system()
	while(Time.get_unix_time_from_system() < last_stun_time + stun_duration):
		#var rand_x: float = randf_range(-2, 2)
		#var rand_y: float = randf_range(-5, 5)
		global_position = Vector2(orig_pos.x, orig_pos.y + y_pos)
		y_pos *= -1
		await get_tree().create_timer(0.05).timeout
		
	#return to normal
	global_position = orig_pos
	move_speed = base_move_speed
	stunned = false
	#hitbox.disabled = false
	_set_invincible(self)

func _set_invincible(player: Costume):
	#disable hitbox
	var hitbox:CollisionShape2D = $Collison
	#hitbox.disabled = true
	
	#player sprite flickers while invul
	var sprite: Sprite2D = $Sprite_Costume
	last_invul_time = Time.get_unix_time_from_system()
	while(Time.get_unix_time_from_system() < last_invul_time + invul_duration):
		sprite.visible = !sprite.visible
		print("visible: " + str(sprite.visible))
		await get_tree().create_timer(0.08).timeout
	
	sprite.visible = true
	hitbox.disabled = false
	invincible = false
