extends Area2D


func _on_body_entered(player: Costume) -> void:
	player.candy_amount += 1
	print("{0}'s candy is now {1}".format([player.costume_name, player.candy_amount]))
	queue_free()
