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
		
		
		
		
		
		
		
#extends Node2D
#
##func _ready():
	##$Player2.active = false
#
#
#func _input(event):
	#if Input.is_action_pressed('player1'):
		#$Player1/AnimatedSprite2D.show()
		#$Player1.animated_sprite = $Player1/AnimatedSprite2D
		#$Player1/robot.hide()
	#if Input.is_action_pressed('player2'):
		#$Player1.player1 = false
		#$Player1/AnimatedSprite2D.hide()
		#$Player1.animated_sprite = $Player1/robot
		#$Player1/robot.show()
		
		
		
		
		
extends Node2D


func _input(event):

	if Input.is_action_pressed('player1'):
		$Player1.player1 = true
		$Player1/AnimatedSprite2D.show()
		$Player1.animated_sprite = $Player1/AnimatedSprite2D
		$Player1/robot.hide()
		  # Reset to player1 state
		reset_animation_state()  # Reset animation state
	if Input.is_action_pressed('player2'):
		$Player1.player1 = false
		$Player1/AnimatedSprite2D.hide()
		$Player1.animated_sprite = $Player1/robot
		$Player1/robot.show()
		reset_animation_state()  # Reset animation state
		

func reset_animation_state():
	$Player1.animated_sprite.stop()  # Stop the current animation
	$Player1.animation_locked = false  # Reset animation lock

var entered = false
var near = false
var begin = false
var end = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if begin:
		near = false
		entered = false
		end = false
		$TextEdit5.show()
	else:
		$TextEdit5.hide()
	if end:
		$TextEdit6.show()
	else:
		$TextEdit6.hide()
	if entered:
		near = false
		begin = false
		end = false
		$Bee/Block.set_deferred("disabled", true)
		$Bee/Smile.show()
		$TextEdit2.show()
	elif near:
		$Player1/Camera2D/TextEdit2.show()
	#insert delay
		$Player1/Camera2D/TextEdit3.show()
		#$Player1/Camera2D/TextEdit4.show()
	else:
		$Bee/Smile.hide()
		$TextEdit2.hide()
		$Player1/Camera2D/TextEdit2.hide()
		$Player1/Camera2D/TextEdit3.hide()
		#$Player1/Camera2D/TextEdit4.hide()
		#$TextEdit5.hide()

func _on_area_2d_body_entered(body):
	if $Player1.player1 and $Player1.smile:
		entered = true
		near = false
		end = false
		#$Player1/Camera2D/TextEdit4.hide()
		$Player1/Camera2D/TextEdit2.hide()
		$Player1/Camera2D/TextEdit3.hide()
	elif $Player1.player1:
		near = false
		#$Player1/Camera2D/TextEdit4.show()

func _on_suggestions_body_entered(body):
	near = true
	
func _on_suggestions2_body_entered(body):
	entered = false
	near = false
	begin = true
	end = false
	$TextEdit5.show()
	


func _on_suggestions3_body_entered(body):
	entered = false
	near = false
	begin = false
	end = true
	$TextEdit6.show()
