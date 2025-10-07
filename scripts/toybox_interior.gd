extends Node2D

@onready var player = $RoomLayout/Player
var climb_speed = 600

func _on_box_touched(body: Node2D) -> void:
	if body.name == "Player":
		player.climb_speed = climb_speed


func _on_box_left(body: Node2D) -> void:
	if body.name == "Player":
		player.climb_speed = 0
