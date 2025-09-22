extends Area2D
@onready var indicator = $"../InteractIndicator"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_body_entered(_body: Node2D) -> void:
	indicator.text = "W to speak"


func _on_body_exited(_body: Node2D) -> void:
	indicator.text = " "
