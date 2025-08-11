"""
A house contains candy for the players to collect. A house can have a maximum of 10 candies, 
but it can have a small chance to contain 20 candies instead.
Players must stand in front of the house to collect candy.
"""

extends Node2D
class_name House

#sigals
signal on_house_empty(house: House)

@onready var candy_text : Label = $"Candy Text"
@export var house_light_on: String = "res://Sprites/HouseOn.png"
@export var house_light_off: String = "res://Sprites/HouseOff.png"
@onready var house_sprite: Sprite2D = $House_Light
@export var candy_amount : int = 0
@export var restock_time : float = 0    #time in seconds that must pass before house has candy. This value is randomized for each house.
var last_restock_time : float           #gets timestamp of current time to enable cooldown for restocking candy
var last_candy_pickup_time : float
@export var candy_amount_hidden : bool  #if true, players will not know how much candy a house has until they approach
@export var can_stock_candy : bool  	#must be true in order to stock candy
@export var candy_being_collected : bool
@export var player: Costume					#reference to player that's in front of house

#consts
const MAX_CANDY_AMOUNT: int = 10;
const MIN_RESTOCK_TIME: int = 5;
const MAX_RESTOCK_TIME: int = 10;
const CANDY_PICKUP_RATE: float = 0.5   #time in seconds that player acquires candy from a house.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#candy_text.text = "11"
	#house_sprite.texture = load(house_light_on)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if candy_being_collected:
		var time = Time.get_unix_time_from_system()
		if time > last_candy_pickup_time + CANDY_PICKUP_RATE:
			#player gets candy
			last_candy_pickup_time = time
			
			if candy_amount < player.candy_taken:
				player.candy_taken = candy_amount
			else:
				player.candy_taken = player.default_candy_taken
			
			player.candy_amount += player.candy_taken
			candy_amount -= player.candy_taken
			
			#update label
			candy_text.text = str(candy_amount)
			
			if candy_amount <= 0:
				#time to restock
				#last_restock_time = Time.get_unix_time_from_system()
				#restock_time = randi_range(MIN_RESTOCK_TIME * 2, MAX_RESTOCK_TIME * 2)    #restock takes longer during a game
				#can_stock_candy = false
				#candy_being_collected = false

				#lights out!
				#house_sprite.texture = load(house_light_off)
				#TODO: update house manager to have 1 less house with candy.
				on_house_empty.emit(self)


func _on_candy_pickup_area_entered(player: Costume) -> void:
	print("{0} is in front of house {1}".format([player.costume_name, name]))

	#player shouts "trick or treat" and then collects candy at a fixed rate
	if candy_amount <= 0:
		return
	
	self.player = player
	#TODO: display "trick or treat for half a second
	await get_tree().create_timer(0.5).timeout
	#TODO: player collects candy until they move away from house or house is empty
	candy_being_collected = true;

#adds candy to house	
func stock_up(amount: int):
	candy_amount = amount

func lights_on():
	house_sprite.texture = load(house_light_on)
	
func lights_off():
	house_sprite.texture = load(house_light_off)
	

func _on_candy_pickup_area_exited(player: Costume) -> void:
	candy_being_collected = false;
	print("{0} has left house {1}".format([player.costume_name, name]))
