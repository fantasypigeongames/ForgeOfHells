class_name PlayerStateRun
extends PlayerState


func init() -> void:
	#print("init: ", name)
	pass
	
func enter() -> void:
	print("enter: ", name)
	pass
	
func exit() -> void:
	print("exit: ", name)
	pass
	
#what happens when input is pressed/released
func handle_input( _event : InputEvent ) -> PlayerState:
	return next_state
	
#override built in process and physics fucntions for each player state
func process ( _delta: float ) -> PlayerState:
	if player.direction.x == 0:
		return idle
	if Input.is_action_just_pressed("jump"):
		return jump
	return next_state
	
func physics_process ( _delta: float ) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
