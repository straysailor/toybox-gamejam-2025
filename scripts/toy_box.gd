extends Node2D


var player_in_range = false
var toybox_open = false
var has_been_opened = false

@onready var sprite = $Area2D/ToyboxSprite
@onready var anim_player = $AnimationPlayer

func _on_toybox_body_entered(body: Node2D) -> void:
	if body.name == "Player" and GameManager.inventory.check_for_item("Magic Wand") > 0:
		player_in_range = true
		if !has_been_opened:
			anim_player.play("shake")

func _on_toybox_area_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false
		if toybox_open:
			sprite.play("close")
			toybox_open = false
		anim_player.stop(false)
		
func _input(event: InputEvent) -> void:
	if player_in_range and event.is_action_pressed("interact"):
		anim_player.stop(false)
		if !toybox_open:
			has_been_opened = true
			toybox_open = true
			sprite.play("open")
		else:
			GameManager.player_spawn_side = "middle"
			Global.next_scene = "res://scenes/toybox_interior.tscn";
			get_tree().change_scene_to_packed(Global.loading_screen)
		
