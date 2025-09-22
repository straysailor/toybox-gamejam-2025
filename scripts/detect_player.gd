extends Area2D
@onready var indicator = $"../InteractIndicator/AnimationPlayer"

func _on_body_entered(_body: Node2D) -> void:
	indicator.play("fade_text")

func _on_body_exited(_body: Node2D) -> void:
	indicator.stop(false)
