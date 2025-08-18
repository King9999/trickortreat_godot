extends Node

#player controls
const left_p1: String = "P1_Left"
const right_p1: String = "P1_Right"
const up_p1: String = "P1_Up"
const down_p1: String = "P1_Down"
const confirm_p1: String = "P1_Trick"
const left_p2: String = "P2_Left"
const right_p2: String = "P2_Right"
const up_p2: String = "P2_Up"
const down_p2: String = "P2_Down"
const confirm_p2: String = "P2_Trick"

#Used to save player's costume pick
enum Selection { GHOST, KNIGHT, PRINCESS, WITCH }
var costume_p1: Selection
var costume_p2: Selection

#save number of cpu opponents
var cpu_opponent_count: int = 0
var rand_cpu_costume: Selection		#Used when 1 CPU opponent is chosen
var cpu_costumes: Array[Singleton.Selection] = []

#scene names for easy reference
var cpu_select_scene: String = "res://Scenes/cpu_select.tscn"
var main_game_scene: String = "res://Scenes/main.tscn"

#game Parameters
var json_param			#holds costume data such as trick cooldown, candy taken, etc.

func _ready() -> void:
	#read parameters JSON file
	var file = FileAccess.open("res://Data/parameters.json", FileAccess.READ)
	json_param = JSON.parse_string(file.get_as_text())
	file.close()
	#print(json_param[0].costume_name)
	

#Gets a random opponent for 3-player games (1 CPU opponent)
func get_random_opponent():
	#var cpu_costumes: Array[Singleton.Selection] = []
	get_cpu_opponents()
	
	#get a random opponent
	var rand_opponent = randi() % cpu_costumes.size()
	rand_cpu_costume = cpu_costumes[rand_opponent]
	
#gets remaining costumes for CPUs
func get_cpu_opponents():
	for costume in Selection.values():
		if costume_p1 == costume || costume_p2 == costume:
			#cpu cannot be this costume
			continue
		cpu_costumes.append(costume)
