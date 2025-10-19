class_name PlayerStateFall
extends PlayerState

func init() -> void:
	#print("init: ", name)
	pass
	
func enter() -> void:
	print("enter: ", name)
	player.velocity = Vector2.ZERO
	pass
	
func exit() -> void:
	print("exit: ", name)
	player.add_debug_indicator( Color.RED )
	pass
	
#what happens when input is pressed/released
func handle_input( _event : InputEvent ) -> PlayerState:
	return next_state
	
#override built in process and physics fucntions for each player state
func process ( _delta: float ) -> PlayerState:
	#if player.is_on_floor():
		#player.change_state( idle )
	player.velocity.x = player.direction.x * player.move_speed
	
	return next_state
	
func physics_process ( _delta: float ) -> PlayerState:
	if player.is_on_floor():
		return idle
	return next_state
