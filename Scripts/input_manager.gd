"""
Handles controls on the costume select screen
"""

extends Node2D

@onready var cursor_p1: Sprite2D = $"P1 Cursor"
@onready var cursor_p2: Sprite2D = $"P2 Cursor"
var input_p1: InputEvent
var input_p2: InputEvent

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

#references to costume sprites
enum Selection { GHOST, KNIGHT, PRINCESS, WITCH }
@export var costume_p1: Selection
@export var costume_p2: Selection
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
	costume_p1 = Selection.GHOST
	costume_p2 = Selection.KNIGHT
	pass # Replace with function body.



func _process(delta: float) -> void:
	#Player 1 controls
	if Input.is_action_just_pressed(left_p1):	#is_action_just_pressed executes action only once
		#move P1 cursor left
		if (costume_p1 <= 0):
			costume_p1 = Selection.size() - 1
		else:
			costume_p1 -= 1		
		print(Selection.keys()[costume_p1])
	if Input.is_action_just_pressed(right_p1):
		if (costume_p1 >= Selection.size() - 1):
			costume_p1 = 0
		else:
			costume_p1 += 1
		print(Selection.keys()[costume_p1])
	if Input.is_action_just_pressed(confirm_p1):
		print("P1 Selected {0}".format([Selection.keys()[costume_p1]]))
	
	#Player 2 controls
	if Input.is_action_just_pressed(left_p2):
		if (costume_p2 <= 0):
			costume_p2 = Selection.size() - 1
		else:
			costume_p2 -= 1
		print("P2 Presed left")
	if Input.is_action_just_pressed(right_p2):
		if (costume_p2 >= Selection.size() - 1):
			costume_p2 = 0
		else:
			costume_p2 += 1
		print("P2 Presed right")
	if Input.is_action_just_pressed(confirm_p2):
		print("P2 Selected costume")
	
	#update cursor positions
	match (costume_p1):
		Selection.GHOST:
			cursor_p1.global_position = ghost_sprite.global_position + offset 
		Selection.KNIGHT:
			cursor_p1.global_position = knight_sprite.global_position + offset
		Selection.PRINCESS:
			cursor_p1.global_position = princess_sprite.global_position + offset
		Selection.WITCH:
			cursor_p1.global_position = witch_sprite.global_position + offset
			
	match (costume_p2):
		Selection.GHOST:
			cursor_p2.global_position = ghost_sprite.global_position + offset 
		Selection.KNIGHT:
			cursor_p2.global_position = knight_sprite.global_position + offset
		Selection.PRINCESS:
			cursor_p2.global_position = princess_sprite.global_position + offset
		Selection.WITCH:
			cursor_p2.global_position = witch_sprite.global_position + offset
	
	#shift cursor positions so they don't overlap		
	if costume_p1 == costume_p2:
		cursor_p1.global_position = cursor_p1.global_position + x_offset_cursor1
		cursor_p2.global_position = cursor_p2.global_position + x_offset_cursor2
