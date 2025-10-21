class_name PlayerStateFall
extends PlayerState

@export var coyote_time : float = 0.125
@export var fall_gravity_multiplier : float = 1.165
@export var jump_buffer_time : float = 0.2

var coyote_timer : float = 0
var buffer_timer : float = 0

func init() -> void:
	#print("init: ", name)
	pass
	
func enter() -> void:
	print("enter: ", name)
	player.gravity_multiplier = fall_gravity_multiplier
	if player.previous_state == jump:
		coyote_timer = 0
	else:
		coyote_timer = coyote_time
	#play fall animation
	
	
	pass
	
func exit() -> void:
	print("exit: ", name)
	player.add_debug_indicator( Color.RED )
	player.gravity_multiplier = 1.0
	pass
	
#what happens when input is pressed/released
func handle_input( event : InputEvent ) -> PlayerState:
	if event.is_action_pressed( "jump" ):
		if coyote_timer > 0:
			return jump
		else:
			buffer_timer = jump_buffer_time
	return next_state
	
#override built in process and physics fucntions for each player state
func process ( _delta: float ) -> PlayerState:
	#if player.is_on_floor():
		#player.change_state( idle )
	#player.velocity.x = player.direction.x * player.move_speed
	
	coyote_timer -= _delta
	buffer_timer -= _delta
	return next_state
	
func physics_process ( _delta: float ) -> PlayerState:
	if player.is_on_floor():
		if buffer_timer > 0: 
			return jump
		return idle
	return next_state
