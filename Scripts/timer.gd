extends Node2D

@export var time: float           	#time in seconds. Will use this value to get the minutes, seconds and milliseconds
@export var init_time: float      	#the initial start time. Used to get time elapsed.
@export var timer_running: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func display_timer() -> String:
	var minutes: float = floorf(time / 60)
	var seconds: float = floorf(time as int % 60)			#"as" keyword casts from 1 type to another
	var milliseconds: float = time as int % 1 * 99
	
	#use format to display time with colons
	var time_text: String = "{0:0}:{1:00}:{2:00}".format([minutes, seconds, milliseconds])
	return time_text
	
