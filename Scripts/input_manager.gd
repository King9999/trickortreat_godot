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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	#Player 1 controls
	if Input.is_action_just_pressed(left_p1):	#is_action_just_pressed executes action only once
		#move P1 cursor left
		print("P1 Presed left")
	if Input.is_action_just_pressed(right_p1):
		print("P1 Presed right")
	if Input.is_action_just_pressed(up_p1):
		print("P1 Presed up")
	if Input.is_action_just_pressed(down_p1):
		print("P1 Presed down")
	if Input.is_action_just_pressed(confirm_p1):
		print("P1 Selected costume")
	
	#Player 2 controls
	if Input.is_action_just_pressed(left_p2):
		print("P2 Presed left")
	if Input.is_action_just_pressed(right_p2):
		print("P2 Presed right")
	if Input.is_action_just_pressed(up_p2):
		print("P2 Presed up")
	if Input.is_action_just_pressed(down_p2):
		print("P2 Presed down")
	if Input.is_action_just_pressed(confirm_p2):
		print("P2 Selected costume")
	
