extends Control

#Start the game
func _on_start_pressed() -> void:
	Global.next_scene = "res://scenes/room_1.tscn"
	get_tree().change_scene_to_packed(Global.loading_screen)
