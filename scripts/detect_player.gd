extends Area2D
@onready var indicator = $"../InteractIndicator/AnimationPlayer"
@onready var text = $"../InteractIndicator"
var player_in_range = false
var text_default = "Speak\nv"
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = true
		indicator.play("fade_text")

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		text.text = text_default
		player_in_range = false
		indicator.stop(false)
		
func _input(event: InputEvent) -> void:
	if player_in_range and event.is_action_pressed("interact"):
		indicator.stop(false)
		text.label_settings.font_color = Color(255.0, 255.0, 255.0, 1.0)
		text.text = "Hello\nv"
