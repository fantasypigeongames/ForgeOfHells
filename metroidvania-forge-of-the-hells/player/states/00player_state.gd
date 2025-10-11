@icon("res://player/states/state.svg")
class_name PlayerState extends Node

var player : Player
var next_state : PlayerState

#region ///state references 
# reference to all other states
@onready var idle: PlayerStateIdle = %Idle
@onready var run: PlayerStateRun = %Run
@onready var jump: PlayerStateJump = %Jump
@onready var fall: PlayerStateFall = %Fall

#endregion


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
	return next_state
	
func physics_process ( _delta: float ) -> PlayerState:
	return next_state

#region ///BOILERPLATE NEW STATE CODE
#class_name PlayerStateNAME 
#extends PlayerState
#
#func init() -> void:
	##print("init: ", name)
	#pass
	#
#func enter() -> void:
	#print("enter: ", name)
	#pass
	#
#func exit() -> void:
	#print("exit: ", name)
	#pass
	#
##what happens when input is pressed/released
#func handle_input( _event : InputEvent ) -> PlayerState:
	#return next_state
	#
##override built in process and physics fucntions for each player state
#func process ( _delta: float ) -> PlayerState:
	#return next_state
	#
#func physics_process ( _delta: float ) -> PlayerState:
	#return next_state
#endregion
