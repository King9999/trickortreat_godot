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
	pass # Replace with function body.
	
func enable_slash(toggle: bool, direction: Vector2 = Vector2(0,0)):
	set_process(toggle)
	visible = toggle
	if (toggle == true):
		#flip or rotate slash sprite depending on direction
		#reset values before checking
		slash_sprite.rotation_degrees = 0
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
			slash_sprite.rotation_degrees -= 90
			if direction.x != 0:
				direction.x = 0
		elif direction.y < 0:
			direction.y = -1
			slash_sprite.flip_v = true
			#slash_sprite.rotation_degrees = 0
			slash_sprite.rotation_degrees += 90
			if direction.x != 0:
				direction.x = 0
				
		global_position = costume.global_position + (direction * offset)
