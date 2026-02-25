@icon( "res://general/icons/player_spawn.svg" )
class_name PlayerSpawn extends Node2D

#hide this node in game
#needs to check if there is a player, and if not, make one
#position player 

func _ready() -> void:
	visible = false
	await get_tree().process_frame
	
	if get_tree().get_first_node_in_group( "Player" ):
		print("Player found")
		
	print("NO PLAYER FOUND")
	var player : Player = load( "uid://ddto2sv8dasbg" ).instantiate()
	get_tree().root.add_child( player )
	player.global_position = self.global_position
	
	pass
