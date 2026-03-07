class_name PauseMenu
extends CanvasLayer

#region ///onready variables
@onready var pause_screen: Control = %PauseScreen
@onready var system: Control = %System

@onready var system_menu_button: Button = %SystemMenuButton

@onready var back_to_title: Button = %BackToTitle
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SFXSlider
@onready var ui_slider: HSlider = %UISlider
#endregion

var player : Player 

func _ready() -> void: 
	#grab player
	show_pause_screen()
	system_menu_button.pressed.connect( show_system_menu )
	#audio
	#setup system
	pass
	
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed( "pause" ):
		get_viewport().set_input_as_handled()
		get_tree().paused = false
		queue_free()
	pass
	
func show_pause_screen() -> void:
	pass

func show_system_menu() -> void:
	pass
