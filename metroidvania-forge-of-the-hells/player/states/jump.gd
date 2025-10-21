class_name PlayerStateJump
extends PlayerState

@export var jump_velocity : float = 450.0

func init() -> void:
	#print("init: ", name)
	pass
	
func enter() -> void:
	print("enter: ", name)
	#play jump animation
	player.add_debug_indicator( Color.LAWN_GREEN )
	player.velocity.y = -jump_velocity
	pass
	
func exit() -> void:
	print("exit: ", name)
	player.add_debug_indicator( Color.YELLOW )
	pass
	
#what happens when input is pressed/released
func handle_input( event : InputEvent ) -> PlayerState:
	if event.is_action_released("jump"):
		print("JUMP RELEASED")
		player.velocity.y *= 0.5
		return fall
	return next_state
	
func process ( _delta: float ) -> PlayerState:	
	return next_state
	
func physics_process ( _delta: float ) -> PlayerState:
	if player.is_on_floor():
		return idle
	if player.velocity.y >= 0:
		return fall
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
	
	
	
	##ep 03 homework. update enter to the above code to be velocity based, not timer based jump
	#var duration_timer : Timer = Timer.new()
	#duration_timer.one_shot = true
	#duration_timer.wait_time = 0.125
	#add_child( duration_timer )
	#duration_timer.timeout.connect( func():
		#_on_duration_timer_timeout(duration_timer) )
	#duration_timer.start()
##ep 03 homework. update process from to the above code to be velocity based, not timer based jump
	#var jump_y_velocity : float = -.5 * player.gravity
	#var x_axis = Input.get_axis("left", "right")
	#var y_axis = Input.get_axis("up", "down")
	#player.direction = Vector2(x_axis,y_axis)
	#player.velocity.x = player.direction.x * player.move_speed
	#player.velocity.y = jump_y_velocity
##ep 03 homework. update to the above code to be velocity based, not timer based jump
#func _on_duration_timer_timeout(timer: Timer) :
	#print("jump duration timer timeout")
	#timer.queue_free()
	#player.change_state( fall )
