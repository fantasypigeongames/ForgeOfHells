class_name PlayerStateIdle 
extends PlayerState



func init() -> void:
	#print("init: ", name)
	pass
	
func enter() -> void:
	print("enter: ", name)
	player.player_animation_player.play("idle")
	pass
	
func exit() -> void:
	print("exit: ", name)
	pass
	
#what happens when input is pressed/released
func handle_input( _event : InputEvent ) -> PlayerState:
	if _event.is_action_pressed("jump"):
		return jump
	return next_state
	
#override built in process and physics fucntions for each player state
func process ( _delta: float ) -> PlayerState:
	if player.direction.x != 0:
		return run
	elif player.direction.y > 0.5:
		return crouch
	#homework ep 03. ep 04 move this to handle_input
	#if Input.is_action_just_pressed("jump"):
		#return jump
	return next_state
	
func physics_process ( _delta: float ) -> PlayerState:
	player.velocity.x = 0
	if player.is_on_floor() == false:
		return fall
	return next_state
