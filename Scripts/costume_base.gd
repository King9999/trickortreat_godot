"""
This is the base script for all costumes in the game. It contains common actions across all costumes.

"""

extends Node2D
class_name Costume
@export var costume_name: String
@export var candy_amount: int
@export var candy_drop_amount: int = 5      # how much candy the player drops when hit. 5 is the default.
@export var candy_taken: int = 1;           #how much candy the player gets from a house per tick
var vx: float
var vy: float
@export var move_speed: float = 1.3        #scales vx and vy. Lower value = slower speed

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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
