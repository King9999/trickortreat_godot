"""
Handles controls on the costume select screen
"""

extends Node2D

@onready var cursor_p1: Sprite2D = $"P1 Cursor"
@onready var cursor_p2: Sprite2D = $"P2 Cursor"
@onready var cursor_p1_ok: Label = $"P1 Cursor/P1 OK Label"
@onready var cursor_p2_ok: Label = $"P2 Cursor/P2 OK Label"
@export var player1_picked: bool
@export var player2_picked: bool

#player controls
"""const left_p1: String = "P1_Left"
const right_p1: String = "P1_Right"
const up_p1: String = "P1_Up"
const down_p1: String = "P1_Down"
const confirm_p1: String = "P1_Trick"
const left_p2: String = "P2_Left"
const right_p2: String = "P2_Right"
const up_p2: String = "P2_Up"
const down_p2: String = "P2_Down"
const confirm_p2: String = "P2_Trick"
"""

#references to costume sprites
"""enum Selection { GHOST, KNIGHT, PRINCESS, WITCH }
@export var costume_p1: Selection
@export var costume_p2: Selection"""
@onready var ghost_sprite: Sprite2D = $"../Ghost"
@onready var knight_sprite: Sprite2D = $"../Knight"
@onready var princess_sprite: Sprite2D = $"../Princess"
@onready var witch_sprite: Sprite2D = $"../Witch"

#offset is applied to cursor
var offset: Vector2 = Vector2(0, -100)
var x_offset_cursor1: Vector2 = Vector2(-20, 0)
var x_offset_cursor2: Vector2 = Vector2(20, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Singleton.costume_p1 = Singleton.Selection.GHOST
	Singleton.costume_p2 = Singleton.Selection.KNIGHT
	cursor_p1_ok.visible = false
	cursor_p2_ok.visible = false


func _process(delta: float) -> void:
	#Player 1 controls
	if !player1_picked:
		if Input.is_action_just_pressed(Singleton.left_p1):	#is_action_just_pressed executes action only once
			#move P1 cursor left
			if (Singleton.costume_p1 <= 0):
				Singleton.costume_p1 = Singleton.Selection.size() - 1
			else:
				Singleton.costume_p1 -= 1		
			#print(Singleton.Selection.keys()[Singleton.costume_p1])
		if Input.is_action_just_pressed(Singleton.right_p1):
			if (Singleton.costume_p1 >= Singleton.Selection.size() - 1):
				Singleton.costume_p1 = 0
			else:
				Singleton.costume_p1 += 1
			#print(Singleton.Selection.keys()[Singleton.costume_p1])
		if Input.is_action_just_pressed(Singleton.confirm_p1):
			#player 1 cannot pick same costume as player 2
			if player2_picked && Singleton.costume_p1 == Singleton.costume_p2:
				return
				
			player1_picked = true
			cursor_p1_ok.visible = true
			#print("P1 Selected {0}".format([Singleton.Selection.keys()[Singleton.costume_p1]]))
		
		#Player 2 controls
	if !player2_picked:
		if Input.is_action_just_pressed(Singleton.left_p2):
			if (Singleton.costume_p2 <= 0):
				Singleton.costume_p2 = Singleton.Selection.size() - 1
			else:
				Singleton.costume_p2 -= 1
			#print("P2 Presed left")
		if Input.is_action_just_pressed(Singleton.right_p2):
			if (Singleton.costume_p2 >= Singleton.Selection.size() - 1):
				Singleton.costume_p2 = 0
			else:
				Singleton.costume_p2 += 1
			#print("P2 Presed right")
		if Input.is_action_just_pressed(Singleton.confirm_p2):
			#player 2 cannot pick same costume as player 1
			if player1_picked && Singleton.costume_p1 == Singleton.costume_p2:
				return
			
			player2_picked = true
			cursor_p2_ok.visible = true
			#print("P2 Selected costume")
	
	#update cursor positions
	match (Singleton.costume_p1):
		Singleton.Selection.GHOST:
			cursor_p1.global_position = ghost_sprite.global_position + offset 
		Singleton.Selection.KNIGHT:
			cursor_p1.global_position = knight_sprite.global_position + offset
		Singleton.Selection.PRINCESS:
			cursor_p1.global_position = princess_sprite.global_position + offset
		Singleton.Selection.WITCH:
			cursor_p1.global_position = witch_sprite.global_position + offset
			
	match (Singleton.costume_p2):
		Singleton.Selection.GHOST:
			cursor_p2.global_position = ghost_sprite.global_position + offset 
		Singleton.Selection.KNIGHT:
			cursor_p2.global_position = knight_sprite.global_position + offset
		Singleton.Selection.PRINCESS:
			cursor_p2.global_position = princess_sprite.global_position + offset
		Singleton.Selection.WITCH:
			cursor_p2.global_position = witch_sprite.global_position + offset
	
	#shift cursor positions so they don't overlap		
	if Singleton.costume_p1 == Singleton.costume_p2:
		cursor_p1.global_position = cursor_p1.global_position + x_offset_cursor1
		cursor_p2.global_position = cursor_p2.global_position + x_offset_cursor2
		
	#check if both players picked their costume, then move to main game scene
	if _both_players_picked_costume():
		await get_tree().create_timer(0.8).timeout
		get_tree().change_scene_to_file(Singleton.cpu_select_scene)

func _both_players_picked_costume():
	return player1_picked && player2_picked
