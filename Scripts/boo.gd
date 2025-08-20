extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enable_boo(toggle: bool):
	#set_process(toggle)
	visible = toggle
	if toggle == false:
		process_mode = Node.PROCESS_MODE_DISABLED	#must use this to completely disable a node instead of set_process
	else:
		process_mode = Node.PROCESS_MODE_ALWAYS

func _on_body_entered(body: Node2D) -> void:
	#target drops 2x the amount of candy 
	var hit_list = get_overlapping_bodies()
	#print(hit_list)
	
	#Check what was hit
	for i in hit_list.size():
		if hit_list[i] == get_parent():  #ignore the ghost
			#var knight = hit_list[i] as Costume
			#print("ignoring {0}".format([knight.costume_name]))
			continue
			 
		var costume = hit_list[i] as Costume
		if (costume != null):
			#player was hit
			costume.take_hit()
			#print("hit {0}".format([costume.costume_name]))
