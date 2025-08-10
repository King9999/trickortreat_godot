"""
Player controls. Can move in 8 directions, and execute a trick when it's available.

"""
extends CharacterBody2D
class_name Costume

signal on_hit(player: Costume)

@export var costume_name: String
@export var candy_amount: int
@export var candy_drop_amount: int = 5      # how much candy the player drops when hit. 5 is the default.
@export var candy_taken: int = 1;           #how much candy the player gets from a house per tick
var vx: float
var vy: float
@export var move_speed: float = 150        #scales vx and vy. Lower value = slower speed

@export_category("Timers & Booleans")
#@export var public float currentTime;                   //used to track when trick can be used again.
var last_invul_time: float             #timestamp to get current time
@export var invul_duration: float = 1.5       #time in seconds. Determines how long player is invincible
@export var invincible: bool
var last_stun_time: float
@export var stun_duration: float = 1          #time in seconds. Player can't move during this time
@export var stunned: bool
@export var collecting_candy: bool			#is true when player is in front of house with candy
@export var trick_duration: float            #how long a trick is active for.
var last_cooldown_time: float           	#time in seconds before trick is recharged. Starts at zero so that trick can be used immediately at game start
@export var trick_cooldown: float           #cooldown of each trick.
var trick_active: bool

#consts  
const MAX_CANDY: int = 999
const INIT_CANDY_DROP_AMOUNT: int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	velocity.x = 0		#velocity is built in to CharacterBody2D
	velocity.y = 0
	
	#check for keyboard input
	if Input.is_key_pressed(KEY_LEFT):
		velocity.x -= move_speed
	
	if Input.is_key_pressed(KEY_RIGHT):
		velocity.x += move_speed
		
	if Input.is_key_pressed(KEY_UP):
		velocity.y -= move_speed
		
	if Input.is_key_pressed(KEY_DOWN):
		velocity.y += move_speed
	
	move_and_slide()	#important func to update physics and movement. Must be called at the end of above code.
