"""
Controls the player information on the main screen.
"""

extends Node2D

class Game_HUD:
	var hud_node: Node2D
	var trick_ok_label: RichTextLabel
	var candy_amount: RichTextLabel
	var costume_sprite: Sprite2D
	var candy_icon: Sprite2D
	var cooldown_bar: TextureProgressBar

var player_huds: Array[Game_HUD] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var game_manager:GameManager = get_parent()
	
	#NOTE: Is there a way to use string formatting to get the file names instead of doing it manually?
	var p1_hud = Game_HUD.new()
	p1_hud.hud_node = $"Player 1 HUD"
	p1_hud.trick_ok_label = $"Player 1 HUD/P1 Trick OK Text"
	p1_hud.candy_amount = $"Player 1 HUD/P1 Candy Amount"
	p1_hud.costume_sprite = $"Player 1 HUD/P1 Costume"
	p1_hud.candy_icon = $"Player 1 HUD/P1 Candy Icon"
	p1_hud.cooldown_bar = $"Player 1 HUD/P1 Trick Cooldown Bar"
	player_huds.append(p1_hud)
	
	var p2_hud = Game_HUD.new()
	p2_hud.hud_node = $"Player 2 HUD"
	p2_hud.trick_ok_label = $"Player 2 HUD/P2 Trick OK Text"
	p2_hud.candy_amount = $"Player 2 HUD/P2 Candy Amount"
	p2_hud.costume_sprite = $"Player 2 HUD/P2 Costume"
	p2_hud.candy_icon = $"Player 2 HUD/P2 Candy Icon"
	p2_hud.cooldown_bar = $"Player 2 HUD/P2 Trick Cooldown Bar"
	player_huds.append(p2_hud)
	
	var p3_hud = Game_HUD.new()
	p3_hud.hud_node = $"Player 3 HUD"
	p3_hud.trick_ok_label = $"Player 3 HUD/P3 Trick OK Text"
	p3_hud.candy_amount = $"Player 3 HUD/P3 Candy Amount"
	p3_hud.costume_sprite = $"Player 3 HUD/P3 Costume"
	p3_hud.candy_icon = $"Player 3 HUD/P3 Candy Icon"
	p3_hud.cooldown_bar = $"Player 3 HUD/P3 Trick Cooldown Bar"
	player_huds.append(p3_hud)
	
	var p4_hud = Game_HUD.new()
	p4_hud.hud_node = $"Player 4 HUD"
	p4_hud.trick_ok_label = $"Player 4 HUD/P4 Trick OK Text"
	p4_hud.candy_amount = $"Player 4 HUD/P4 Candy Amount"
	p4_hud.costume_sprite = $"Player 4 HUD/P4 Costume"
	p4_hud.candy_icon = $"Player 4 HUD/P4 Candy Icon"
	p4_hud.cooldown_bar = $"Player 4 HUD/P4 Trick Cooldown Bar"
	player_huds.append(p4_hud)
	
	#disable player 3 or 4 huds if necessary.
	if Singleton.cpu_opponent_count < 2:
		player_huds[3].hud_node.visible = false
	if Singleton.cpu_opponent_count < 1:
		player_huds[2].hud_node.visible = false
	#lerp?
	#player_huds[0].trick_ok_label.get_theme_color("default_color").lerp(Color.RED, 0.4)
	#lerpf(player_huds[0].trick_ok_label.get_theme_color())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
