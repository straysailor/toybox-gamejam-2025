class_name RoomLayout
extends Node2D

@export var room_name: String
@export var left_exit : String
@export var right_exit : String

func _ready() -> void:
	$DoorLeft.next_scene = left_exit
	$DoorRight.next_scene = right_exit
