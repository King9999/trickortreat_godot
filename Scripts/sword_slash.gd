extends Area2D

@onready var costume: Costume = get_parent()
@onready var slash_sprite: Sprite2D = $"Sword Slash"
var offset: float = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	#Check if the body belongs to a player, and ignore all others
	var hit_list = get_overlapping_bodies()
	print(hit_list)
	
	#Check what was hit
	for i in hit_list.size():
		if hit_list[i] == get_parent():  #ignore the knight
			#var knight = hit_list[i] as Costume
			#print("ignoring {0}".format([knight.costume_name]))
			continue
			 
		var costume = hit_list[i] as Costume
		if (costume != null):
			#player was hit
			costume.take_hit()
			print("hit {0}".format([costume.costume_name]))
	#if body.get_parent() is Costume:
	#print("hit {0}".format([body.get_parent().name]))
	#pass # Replace with function body.
	
func enable_slash(toggle: bool, direction: Vector2 = Vector2(0,0)):
	#set_process(toggle)
	visible = toggle
	if toggle == false:
		process_mode = Node.PROCESS_MODE_DISABLED	#must use this to completely disable a node instead of set_process
	else:
		process_mode = Node.PROCESS_MODE_ALWAYS
		#if (toggle == true):
			#flip or rotate slash sprite depending on direction
			#reset values before checking
		rotation_degrees = 0
		slash_sprite.flip_v = false
		slash_sprite.flip_h = false
		
		if direction.x > 0:
			direction.x = 1			#set to 1 in case we're moving diagonally
			slash_sprite.flip_h = true
			#if y is not 0, we change to 0 because diagonal directions are ignored.
			if direction.y != 0:
				direction.y = 0
		elif direction.x < 0:
			direction.x = -1
			#slash_sprite.rotation_degrees = 0
			slash_sprite.flip_h = false
			if direction.y != 0:
				direction.y = 0
		elif direction.y > 0:
			direction.y = 1
			slash_sprite.flip_v = true
			#slash_sprite.rotation_degrees = 0
			rotation_degrees -= 90
			if direction.x != 0:
				direction.x = 0
		elif direction.y < 0:
			direction.y = -1
			slash_sprite.flip_v = true
			#slash_sprite.rotation_degrees = 0
			rotation_degrees += 90
			if direction.x != 0:
				direction.x = 0
				
		global_position = costume.global_position + (direction * offset)
