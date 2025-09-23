extends Area2D

@onready var text = $InteractIndicator
@onready var indicator = $InteractIndicator/IndicatorAnimation
@onready var anim_tree = $InteractIndicator/AnimationTree

func _on_ready() -> void:
	text.label_settings.font_color = Color(255, 255, 255, 0.0)

func _on_area_entered(body: Node2D) -> void:
	if body.name == "Player":
		anim_tree.set("parameters/fade_blend/blend_amount", 0.5) 

func _on_area_exited(body: Node2D) -> void:
	if body.name == "Player":
		anim_tree.set("parameters/fade_blend/blend_amount", 1.0)
		indicator.play("fade_out")
