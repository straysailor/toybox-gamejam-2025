class_name RoomLayout
extends Node2D

@export var spawn_mid : bool
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
		player.facing = "right"
	elif GameManager.player_spawn_side == "middle":
		player.position.x = 1000
	else:
		player.position.x = $DoorRight.position.x - 300
	if spawn_mid:
		GameManager.player_spawn_side = "middle"


func _on_door_right_body_entered(body: Node2D) -> void:
	if body.name == "Player" and !spawn_mid:
		GameManager.player_spawn_side = "left"


func _on_door_left_body_entered(body: Node2D) -> void:
	if body.name == "Player" and !spawn_mid:
		GameManager.player_spawn_side = "right"


func _on_bed_touched(body: Node2D) -> void:
	if body.name == "Player":
		player.climb_speed = 500

func _on_bed_left(body:Node2D) -> void:
		if body.name == "Player":
			player.climb_speed = 0
