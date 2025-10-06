extends Node2D


@onready var player = $RoomLayout/Player

func _on_bed_touched(body: Node2D) -> void:
	if body.name == "Player":
		player.climb_speed = 500

func _on_bed_left(body:Node2D) -> void:
		if body.name == "Player":
			player.climb_speed = 0
