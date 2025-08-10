"""
A house contains candy for the players to collect. A house can have a maximum of 10 candies, 
but it can have a small chance to contain 20 candies instead.
Players must stand in front of the house to collect candy.
"""

extends Node2D
class_name House

@onready var candy_text : Label = $"Candy Text"
@export var candy_amount : int = 0
@export var restock_time : float = 0    #time in seconds that must pass before house has candy. This value is randomized for each house.
var current_time : float           		#gets timestamp of current time to enable cooldown for restocking candy
var last_candy_pickup_time : float		
@export var candy_amount_hidden : bool  #if true, players will not know how much candy a house has until they approach
@export var can_stock_candy : bool  	#must be true in order to stock candy
@export var candy_being_collected : bool
#TODO: Add variable that holds reference to costume that's in front of house

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#candy_text.text = "11"
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
