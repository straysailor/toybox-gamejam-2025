extends Control

var end
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	end = GameManager.get_ending()
	$"Ending Text".text = end
