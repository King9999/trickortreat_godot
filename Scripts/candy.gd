extends Area2D

class_name Candy
#@onready var hitbox: CollisionShape2D = $CollisionShape2D

func _on_body_entered(player: Costume) -> void:	
	#prevent candy from being picked up if it's too close to a stunned player
	if player.stunned:
		return
		
	player.candy_amount += 1
	player.candy_collect_ui.show_candy_collection(true, 1)
	print("{0}'s candy is now {1}".format([player.costume_name, player.candy_amount]))
	
	#remove candy from candy list
	var game_manager: GameManager = get_parent()		#should get Main node
	game_manager.candy_list.erase(self)
	queue_free()
