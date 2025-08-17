extends Node2D

@onready var label_none: Label = $"../Label_None"
@onready var label_opponent1: Label = $"../Label_One Opponent"
@onready var label_opponent2: Label = $"../Label_Two Opponents"
@onready var cursor: Sprite2D = $Cursor

enum Cpu_Opponents { NONE, ONE, TWO }
var cpu_count: Cpu_Opponents
var ready_to_play: bool				#prevents further input once player makes a selection. 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !ready_to_play:
		if Input.is_action_just_pressed(Singleton.down_p1):
			if (cpu_count >= Cpu_Opponents.size() - 1):
				cpu_count = 0
			else:
				cpu_count += 1		
			print(Cpu_Opponents.keys()[cpu_count])
			
		if Input.is_action_just_pressed(Singleton.up_p1):
			if (cpu_count <= 0):
				cpu_count = Cpu_Opponents.size() - 1
			else:
				cpu_count -= 1		
			print(Cpu_Opponents.keys()[cpu_count])
		
		if (Input.is_action_just_pressed(Singleton.confirm_p1)):
			ready_to_play = true
			match(cpu_count):
				Cpu_Opponents.NONE:
					Singleton.cpu_opponent_count = 0
				Cpu_Opponents.ONE:
					#choose a random costume among the ones players didn't pick
					Singleton.get_random_opponent()
					Singleton.cpu_opponent_count = 1
				Cpu_Opponents.TWO:
					Singleton.get_cpu_opponents()
					Singleton.cpu_opponent_count = 2
					
			#switch scene
			await get_tree().create_timer(0.8).timeout
			get_tree().change_scene_to_file(Singleton.main_game_scene)
				
		#update cursor position
		match(cpu_count):
			Cpu_Opponents.NONE:
				cursor.global_position = Vector2(label_none.global_position.x - (label_none.size.x / 4), label_none.global_position.y + (label_none.size.y / 1.5))
			Cpu_Opponents.ONE:
				cursor.global_position = Vector2(label_opponent1.global_position.x - (label_opponent1.size.x / 4), label_opponent1.global_position.y + (label_opponent1.size.y / 1.5))
			Cpu_Opponents.TWO:
				cursor.global_position = Vector2(label_opponent2.global_position.x - (label_opponent2.size.x / 4), label_opponent2.global_position.y + (label_opponent2.size.y / 1.5))
	
