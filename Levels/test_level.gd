#extends Node2D
#
#var is_player_one = true
#var is_player_two = false
#var player1_path = 'res://Character/player.tscn'
#var player2_path = 'res://player2.tscn'
#var current_player = null
#
#func _ready():
	#if is_player_one:
		#current_player = load(player1_path)		#.instance()
	#else:
		#current_player = load(player2_path)		#.instance()
	##add_child(current_player)
#
#func _input(event):
	#if event.is_action_pressed("player1"):
		#switch_to_player1()
	#elif event.is_action_pressed("player2"):
		#switch_to_player2()
#
#func switch_to_player1():
	#if !is_player_one:
		#is_player_one = true
		#is_player_two = false
		#current_player.queue_free()
		#current_player = load(player1_path).instance()
		#add_child(current_player)
#
#func switch_to_player2():
	#if !is_player_two:
		#is_player_one = false
		#is_player_two = true
		#current_player.queue_free()
		#current_player = load(player2_path).instance()
		#add_child(current_player)
extends Node2D

func _ready():
	$Player2.active = false
	pass
	
func _input(event):
	if Input.is_action_pressed('player1'):
		$Player1.active
		$Player2/AnimatedSprite2D.hide()
		$Player1/AnimatedSprite2D.show()
	if Input.is_action_pressed('player2'):
		$Player2.active = true
		$Player1/AnimatedSprite2D.hide()
		$Player2/AnimatedSprite2D.show()
		

		
