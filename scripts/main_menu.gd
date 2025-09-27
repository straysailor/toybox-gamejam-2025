extends Control

#Start the game
func _on_start_pressed() -> void:
	Global.next_scene = "res://scenes/room_1.tscn"
	GameManager.player_spawn_side = "left"
	get_tree().change_scene_to_packed(Global.loading_screen)


func _on_ready() -> void:
	DialogueManager.set_up_dialogue()
