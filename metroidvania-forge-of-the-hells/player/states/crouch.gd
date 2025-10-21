class_name PlayerStateCrouch
extends PlayerState

@export var deceleration_rate : float = 10.0

func init() -> void:
	#print("init: ", name)
	pass
	
func enter() -> void:
	print("enter: ", name)
	player.collision_stand.disabled = true
	player.collision_crouch.disabled = false
	pass
	
func exit() -> void:
	print("exit: ", name)
	player.collision_stand.disabled = false
	player.collision_crouch.disabled = true
	pass
	
#what happens when input is pressed/released
func handle_input( _event : InputEvent ) -> PlayerState:
	if _event.is_action_pressed("jump"):
		if player.one_way_platform_raycast.is_colliding() == true:			
			player.position.y += 4
			return fall
		return jump
	return next_state
	
#override built in process and physics fucntions for each player state
func process ( _delta: float ) -> PlayerState:
	if player.direction.y <= 0.5:
		return idle
	return next_state
	
func physics_process ( delta: float ) -> PlayerState:
	player.velocity.x -= player.velocity.x * deceleration_rate * delta
	if player.is_on_floor() == false:
		return fall
	return next_state
