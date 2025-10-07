extends Node2D

@export var next_scene : String

var player_in_range : bool = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false

func _input(event: InputEvent) -> void:
	if player_in_range and event.is_action_pressed("interact"):
		GameManager.player_spawn_side = "left"
		Global.next_scene = next_scene;
		get_tree().change_scene_to_packed(Global.loading_screen)
