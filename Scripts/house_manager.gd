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
const HIDDEN_CANDY_CHANCE: float = 0.2		#20% chance a house's candy is unknown
const MAX_CANDY_AMOUNT: int = 10

func _ready() -> void:
	#get all of house manager's children nodes, which are the houses
	houses.append_array(get_children())
	
	#connect each house's signal to house manager
	for house in houses:
		house.on_house_empty.connect(_turn_off_lights)
	

func _process(delta: float) -> void:
	#check for any houses that can be restrocked
	for house in houses:
		var time = Time.get_unix_time_from_system()
		if !house.can_stock_candy && time > house.last_restock_time + house.restock_time:
			house.can_stock_candy = true
		
		#check if this house can be stocked	
		#if houses_with_candy >= MAX_HOUSES_WITH_CANDY:
			#continue
			
		#houses don't immediately stock up in the beginning and during the game	
		await get_tree().create_timer(1).timeout
		
		if  houses_with_candy < MAX_HOUSES_WITH_CANDY && house.can_stock_candy && house.candy_amount <= 0:
			#roll for a chance to stock house
			if randf() <= STOCK_UP_CHANCE:					#randf() returns 0 to 1 inclusive
				#add candy. Check if this house gets extra candy
				if randf() <= EXTRA_CANDY_CHANCE:
					house.stock_up(MAX_CANDY_AMOUNT * 2)
				else:
					house.stock_up(randi_range(1, MAX_CANDY_AMOUNT))
				
				#does this house have an unknown amount of candy?
				if randf() <= HIDDEN_CANDY_CHANCE:
					house.candy_text.text = "??"
				
				#finished	
				house.lights_on()
				houses_with_candy += 1

#turns off house lights and sets a random restock time before house can have candy again.
#this function is called when a house emits a signal.
func _turn_off_lights(house: House):
	house.last_restock_time = Time.get_unix_time_from_system()
	house.restock_time = randi_range(house.MIN_RESTOCK_TIME * 2, house.MAX_RESTOCK_TIME * 2)    #restock takes longer during a game
	house.can_stock_candy = false
	house.candy_being_collected = false
	#house.house_sprite.texture = load(house.house_light_off)
	house.lights_off()
	#print("{0}'s lights are now off.".format([house.name]))
	houses_with_candy -= 1
