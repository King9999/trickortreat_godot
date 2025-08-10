"""
This script handles the stocking and restocking of candy in all houses. It will also determine if a house contains more candy than the maximum,
and if the candy amount is hidden from the player until they approach the house.

"""

extends Node2D

@export var houses : Array[House] = []
@export var houses_with_candy: int
@export var stock_up_chance: float = STOCK_UP_CHANCE
@export var extra_candy_chance: float = EXTRA_CANDY_CHANCE

#consts
const MAX_HOUSES_WITH_CANDY: int = 5       #the maximum amount of houses that can have candy.
const STOCK_UP_CHANCE: float = 0.5
const EXTRA_CANDY_CHANCE: float = 0.05		#5% chance for a house to have 20 pieces of candy

func _ready() -> void:
	#get all of house manager's children nodes, which are the houses
	houses.append_array(get_children())
	

func _process(delta: float) -> void:
	pass
