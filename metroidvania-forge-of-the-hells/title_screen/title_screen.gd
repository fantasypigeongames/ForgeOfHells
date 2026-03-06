extends CanvasLayer

#region
@onready var main_menu: VBoxContainer = $Control/MainMenu
@onready var new_main_menu: VBoxContainer = $Control/NewMainMenu
@onready var load_main_menu: VBoxContainer = $Control/LoadMainMenu

@onready var new_game_button: Button = %NewGameButton
@onready var load_game_button: Button = %LoadGameButton
@onready var animation_player: AnimationPlayer = $Control/MainMenu/Logo/AnimationPlayer

@onready var new_slot_01: Button = %NewSlot01
@onready var new_slot_02: Button = %NewSlot02
@onready var new_slot_03: Button = %NewSlot03

@onready var load_slot_01: Button = %LoadSlot01
@onready var load_slot_02: Button = %LoadSlot02
@onready var load_slot_03: Button = %LoadSlot03
#endregion

func _ready() -> void:
	new_game_button.pressed.connect( _show_new_game_menu )	
	load_game_button.pressed.connect( _show_load_game_menu )
	new_slot_01.pressed.connect( _on_new_game_pressed.bind( 0 ) )
	new_slot_02.pressed.connect( _on_new_game_pressed.bind( 1 ) )
	new_slot_03.pressed.connect( _on_new_game_pressed.bind( 2 ) )
	load_slot_01.pressed.connect( _on_load_game_pressed.bind( 0 ) )
	load_slot_02.pressed.connect( _on_load_game_pressed.bind( 1 ) )
	load_slot_03.pressed.connect( _on_load_game_pressed.bind( 2 ) )
	#connect to button signals
	#add audio to buttons
	show_main_menu()
	animation_player.animation_finished.connect( _on_animation_finished )
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed( "ui_cancel" ):
		if main_menu.visible == false:
			#audio 
			show_main_menu()
	pass

func show_main_menu() -> void:
	main_menu.visible = true
	new_main_menu.visible = false
	load_main_menu.visible = false
	new_game_button.grab_focus()
	pass

func _on_animation_finished( anim_name : String ) -> void:
	if anim_name == "start":
		animation_player.play( "loop" )
	pass

func _show_new_game_menu() -> void: 	
	main_menu.visible = false
	new_main_menu.visible = true
	load_main_menu.visible = false
	new_slot_01.grab_focus()
	
	if SaveManager.save_file_exists( 0 ):
		new_slot_01.text = "Replace Slot 01"
		
	if SaveManager.save_file_exists( 1 ):
		new_slot_02.text = "Replace Slot 02"
		
	if SaveManager.save_file_exists( 2 ):
		new_slot_03.text = "Replace Slot 03"
	pass
	
func _show_load_game_menu() -> void: 	
	main_menu.visible = false
	new_main_menu.visible = false
	load_main_menu.visible = true
	load_slot_01.grab_focus()
	
	load_slot_01.disabled = not SaveManager.save_file_exists( 0 )
	load_slot_02.disabled = not SaveManager.save_file_exists( 1 )
	load_slot_03.disabled = not SaveManager.save_file_exists( 2 )
	
	pass
	
	
	
func _on_new_game_pressed ( slot : int ) -> void:
	SaveManager.create_new_game_save( slot )
	SceneManager.transition_scene(
		"uid://c4js3kkc415pb",
		"", Vector2.ZERO, "up"
	)
	pass

func _on_load_game_pressed( slot : int ) -> void:
	SaveManager.load_game( slot )
	pass
