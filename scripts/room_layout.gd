class_name RoomLayout
extends Node2D

@export var room_name: String
@export var left_exit : String
@export var right_exit : String
@onready var player = $Player

func _ready() -> void:
	if left_exit == "dead_end":
		$DoorLeft.enabled = false
	if right_exit == "dead_end":
		$DoorRight.enabled = false
		
	$DoorLeft.next_scene = left_exit
	$DoorRight.next_scene = right_exit
	if GameManager.player_spawn_side == "left":
		player.position.x = 300
	else:
		player.position.x = $DoorRight.position.x - 300


func _on_door_right_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameManager.player_spawn_side = "left"


func _on_door_left_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameManager.player_spawn_side = "right"
