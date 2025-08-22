"""
Magic shot travels in the direction the Witch faced last. It moves in a straight line and can hit multiple players.
"""

extends Area2D

var move_speed: float = 50 #600
var vx: float = 1
var vy: float = 1
@onready var sprite: Sprite2D = $"Sprite - Magic"
@onready var witch: Costume = get_parent()
#@onready var house_manager: HouseManager = $"House Manager"
var offset: float = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	top_level = true		#this node can be moved independently of the parent.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("active")
	#var new_pos: Vector2 = Vector2(global_position.x + vx * move_speed * delta, global_position.y + vy * move_speed * delta)
	global_position = Vector2(global_position.x + vx * move_speed * delta, global_position.y + vy * move_speed * delta)
	
	#rotate shot
	sprite.rotation_degrees += 2
	
	#if magic goes off screen, destroy it
	

func enable_magic_shot(toggle: bool, direction: Vector2 = Vector2(0,0)):
	visible = toggle
	if toggle == false:
		process_mode = Node.PROCESS_MODE_DISABLED	#must use this to completely disable a node instead of set_process
	else:
		process_mode = Node.PROCESS_MODE_ALWAYS
		if direction.x > 0:
			direction.x = 1			#set to 1 in case we're moving diagonally
			#if y is not 0, we change to 0 because diagonal directions are ignored.
			if direction.y != 0:
				direction.y = 0
		elif direction.x < 0:
			direction.x = -1
			#slash_sprite.rotation_degrees = 0
			if direction.y != 0:
				direction.y = 0
		elif direction.y > 0:
			direction.y = 1
			#slash_sprite.rotation_degrees = 0
			if direction.x != 0:
				direction.x = 0
		elif direction.y < 0:
			direction.y = -1
			#slash_sprite.rotation_degrees = 0
			if direction.x != 0:
				direction.x = 0
		
		#set up magic
		sprite.rotation_degrees = 0	
		vx = direction.x
		vy = direction.y	
		global_position = witch.global_position + (direction * offset)

func _on_body_entered(body: Node2D) -> void:
	#TODO: must check if shot hit a player or a house. If player was hit, shot keeps going.
	var hit_list = get_overlapping_bodies()
	print(hit_list)
	
	#Check what was hit
	for i in hit_list.size():
		if hit_list[i] == witch:  #ignore the witch
			continue
		
		#var house: House			#TODO: why is this null?
		#print(house) 
		if (body != null && body is not Costume):		
			#house was hit, destroy magic
			print("magic hit house")
			enable_magic_shot(false)
				 
		var costume = hit_list[i] as Costume
		if (costume != null && !costume.stunned):
			#player was hit
			costume.drop_candy(costume.candy_drop_amount)
			costume.take_hit()
		
		
