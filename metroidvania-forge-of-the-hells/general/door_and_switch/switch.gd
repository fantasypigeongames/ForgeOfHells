@icon("res://general/icons/switch.svg")
class_name Switch
extends Node2D

signal activated 
const DOOR_SWITCH_AUDIO = preload("uid://0vlbwnh7lggv")
@onready var area_2d: Area2D = $Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D

var is_open : bool = false

func _ready() -> void:
	if SaveManager.persistent_data.get_or_add( unique_name(), "closed" ) == "open":
		set_open()
	else:
		#connect to signals
		area_2d.body_entered.connect( _on_player_entered )
		area_2d.body_exited.connect( _on_player_exited )
		pass
	pass

func _on_player_entered( _n : Node ) -> void:
	Messages.input_hint_changed.emit( "interact" )
	Messages.player_interacted.connect( _on_player_interacted )
	pass
	
func _on_player_interacted( _player : Player ) -> void:
	print("player interacted")
	SaveManager.persistent_data[ unique_name() ] = "open"
	activated.emit()
	set_open()
	pass

func _on_player_exited ( _n : Node ) -> void: 	
	Messages.input_hint_changed.emit( "" )
	Messages.player_interacted.disconnect( _on_player_interacted )
	pass

func set_open() -> void : 
	is_open = true
	sprite_2d.flip_h = true
	sprite_2d.modulate = Color.WEB_GRAY
	area_2d.queue_free()
	pass

func unique_name() -> String : 
	var u_name : String # = ResourceUID.path_to_uid( owner.scene_file_path ) #returns a uid, not available in 4.5
	u_name += "/" + get_parent().name + "/" + name  #if multiple doors on same level, need to have doors with unique node display name . less exhastive way to save but need to watch naming convention. 
	
	#return u_name
	return "door_01"
