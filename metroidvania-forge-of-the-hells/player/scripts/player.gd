class_name Player 
extends CharacterBody2D

#PLAYER BUGS 2/24/26
#on jump, when holding z, does not cycle through jump animation as expected 
#on jump, does not accurately respond to when jump key is released

#region ///onready variables
@onready var player_sprite: Sprite2D = $Sprite2D
@onready var player_animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_stand: CollisionShape2D = $CollisionStand
@onready var collision_crouch: CollisionShape2D = $CollisionCrouch
@onready var one_way_platform_shape_cast: ShapeCast2D = $OneWayPlatformShapeCast2D
#endregion

const DEBUG_JUMP_INDICATOR = preload("res://player/debug_jump_indicator.tscn")
#region ///export variables
@export var move_speed : float = 200 #originally 150, changed to 200 for convenience
@export var max_fall_velocity : float = 600
#endregion

#region ///state machine variables
var states : Array[ PlayerState ]
var current_state: PlayerState : 
	get : return states.front()
var previous_state : PlayerState : 
	get : return states[ 1 ]
#endregion

#region /// player stats
var hp : float = 20 : 
	set( value ):
		hp = clampf( value, 0, max_hp )
		Messages.player_health_changed.emit( hp, max_hp )
var max_hp : float = 20 :
	set( value ):
		max_hp = value
		Messages.player_health_changed.emit( hp, max_hp )
		
var dash : bool = false
var double_jump : bool = false
var ground_slam : bool = false
var morph_roll : bool = false
#endregion 

#region ///standard variables
var direction : Vector2 = Vector2.ZERO
var gravity : float = 980
var gravity_multiplier : float = 1.0
#endregion

func _ready() -> void:
	if get_tree().get_first_node_in_group("Player") != self:
		self.queue_free()
	initialize_states()
	self.call_deferred("reparent",  get_tree().root )
	Messages.player_healed.connect( _on_player_healed )
	pass
	
func _unhandled_input( event: InputEvent ) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_MINUS:
			if Input.is_key_pressed( KEY_SHIFT ):
				max_hp -= 10
			else:
				hp -= 2
		elif event.keycode == KEY_EQUAL:
			if Input.is_key_pressed( KEY_SHIFT ):
				max_hp += 10
			else:
				hp += 2
		
		
		
	if event.is_action_pressed( "action" ): 
		Messages.player_interacted.emit( self )
	elif event.is_action_pressed( "pause" ):
		get_tree().paused = true
		var pause_menu : PauseMenu = load( "res://pause_menu/pause_menu.tscn" ).instantiate()
		add_child( pause_menu )
		
	change_state( current_state.handle_input( event ))

func _process(_delta: float) -> void:
	#runs every tick at the variable rate of the game run on a screen fps
	update_direction()
	move_and_slide()
	change_state( current_state.process( _delta ) )
	pass

func _physics_process(_delta: float) -> void:
	#runs every tick at a locked frame rate per project
	velocity.y += gravity * _delta * gravity_multiplier
	velocity.y = clampf( velocity.y, -1000, max_fall_velocity) #-1000 max jump velocity could be used for jump boards
	change_state( current_state.physics_process( _delta ) )
	
	#print(velocity)
	pass
	
func initialize_states() -> void :
	states = []
	#gather all states
	for c in $States.get_children():
		if c is PlayerState:
			states.append( c )
			c.player = self			
	#print(states)
	
	if states.size() == 0: #failsafe
		return
		
	#initialize all states
	for state in states:
		state.init()
		
	#set our first state
	change_state( current_state )
	current_state.enter()	
	$Label.text = current_state.name
	pass

func change_state( new_state : PlayerState ) -> void:
	if new_state == null:
		return
	elif new_state == current_state:
		return
	if current_state:
		current_state.exit()
		
	states.push_front( new_state )
	current_state.enter()
	states.resize( 3 )
	$Label.text = current_state.name
	pass
	
func update_direction() -> void:
	var prev_direction : Vector2
	
	#####direction = Input.get_vector("left", "right", "up", "down") REPLACE THIS WITH INDIVIDUAL GET AXIS TO PREVENT STICK DRIFT
	var x_axis = Input.get_axis("left", "right")
	var y_axis = Input.get_axis("up", "down")
	direction = Vector2(x_axis,y_axis)
	
	if prev_direction.x != direction.x:
		if direction.x < 0: 
			player_sprite.flip_h = true
		elif direction.x > 0: 
			player_sprite.flip_h = false
	pass
	

func add_debug_indicator(color : Color = Color.RED) -> void:
	var d : Node2D = DEBUG_JUMP_INDICATOR.instantiate()
	get_tree().root.add_child( d )
	d.global_position = global_position
	d.modulate = color
	await get_tree().create_timer(3.0).timeout
	d.queue_free()
	pass
	
func _on_player_healed ( amount : float ) -> void : 
	hp += amount
	print("Player healed for: " + str(amount) )
	pass
