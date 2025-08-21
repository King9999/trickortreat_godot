"""
This node is displayed whenever a player collects candy. It animates for a duration then is hidden.
"""

extends Node2D
class_name CandyCollectUI

@onready var candy_collect_label: Label = $Label
var animate: bool
var duration: float = 0.5
var last_animate_time: float
var move_speed: float = 50

const DEFAULT_X: float = -18
const DEFAULT_Y: float = -25

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if animate == true:
		var time = Time.get_unix_time_from_system()
		if time < last_animate_time + duration:
			#animate
			global_position = Vector2(global_position.x, global_position.y - move_speed * delta)
		else:
			show_candy_collection(false)
			
func show_candy_collection(toggle: bool, candy_amount: int = 0):
	visible = toggle
	global_position = Vector2(get_parent().global_position.x + DEFAULT_X, get_parent().global_position.y + DEFAULT_Y)
	if toggle == true:
		candy_collect_label.text = "+%d" % candy_amount
		animate = true
		last_animate_time = Time.get_unix_time_from_system()
	#else:
		#reset position. get_parent() should return Costume node.
		#global_position = Vector2(get_parent().global_position.x + DEFAULT_X, get_parent().global_position.y + DEFAULT_Y)
	
