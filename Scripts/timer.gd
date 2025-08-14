extends Node2D

class_name Game_Timer

@export var time: float           	#time in seconds. Will use this value to get the minutes, seconds and milliseconds
@export var init_time: float      	#the initial start time. Used to get time elapsed.
@export var timer_running: bool
@onready var time_label: RichTextLabel = $"Timer Label"

#const INIT_TIME:float = 120

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#set_timer(INIT_TIME)
	#start_timer(true)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer_running:
		time -= delta
		
		#Change text colour if time almost up
		if _time_running_out():
			time_label.add_theme_color_override("default_color", Color.RED)
		
		if time <= 0:
			time = 0
			timer_running = false
	
		time_label.text = _display_timer()
	
func set_timer(seconds: float):
	if (seconds < 0):
		return
		
	init_time = seconds
	time = seconds
	time_label.text = _display_timer()

##Converts time to minutes, seconds and milliseconds.[br]
##Returns a formatted string.
func _display_timer() -> String:
	var minutes: float = time / 60
	var seconds: float = fmod(time, 60)
	var milliseconds: float = fmod(time, 1) * 100		#fmod must be used instead of % for floats
	#print(milliseconds)
	
	#use format to display time with colons
	#% is a placeholder. 'd' is a decimal specifier, which will floor any values. The "02" is padding; the 0 says to insert extra space with a 0, and the 2 is the minimum length
	#var time_text: String = "%02d:%02d:%02d" % [minutes, seconds, milliseconds]
	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]

func start_timer(toggle: bool):
	timer_running = toggle

func _time_running_out() -> bool:
	return time < 11

func get_elapsed_time():
	return init_time - time
