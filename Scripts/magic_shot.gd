"""
Magic shot travels in the direction the Witch faced last. It moves in a straight line and can hit multiple players.
"""

extends Area2D

var move_speed: float = 600
var vx: float = 1
var vy: float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("active")
	var new_pos: Vector2 = Vector2(global_position.x + vx * move_speed * delta, global_position.y + vy * move_speed * delta)
	global_position = new_pos

func enable_magic_shot(toggle: bool):
	set_process(toggle)
	visible = toggle

func _on_body_entered(body: Node2D) -> void:
	#TODO: must check if shot hit a player or a house. If player was hit, shot keeps going.
	pass # Replace with function body.
