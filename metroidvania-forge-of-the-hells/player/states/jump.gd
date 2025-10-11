class_name PlayerStateJump
extends PlayerState

func init() -> void:
	#print("init: ", name)
	pass
	
func enter() -> void:
	print("enter: ", name)
	#play jump animation
	var duration_timer : Timer = Timer.new()
	duration_timer.one_shot = true
	duration_timer.wait_time = 0.125
	add_child( duration_timer )
	duration_timer.timeout.connect( func():
		_on_duration_timer_timeout(duration_timer) )
	duration_timer.start()
	
	pass
	
func exit() -> void:
	print("exit: ", name)
	pass
	
#what happens when input is pressed/released
func handle_input( _event : InputEvent ) -> PlayerState:
	return next_state
	
#override built in process and physics fucntions for each player state
func process ( _delta: float ) -> PlayerState:
	var jump_y_velocity : float = -.5 * player.gravity
	var x_axis = Input.get_axis("left", "right")
	var y_axis = Input.get_axis("up", "down")
	player.direction = Vector2(x_axis,y_axis)
	player.velocity.x = player.direction.x * player.move_speed
	player.velocity.y = jump_y_velocity
	return next_state
	
func physics_process ( _delta: float ) -> PlayerState:
	return next_state
	
func _on_duration_timer_timeout(timer: Timer) :
	print("jump duration timer timeout")
	timer.queue_free()
	player.change_state( fall )
