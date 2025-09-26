class_name Door
extends Area2D

@export var text : String
@export var side : String
@export var color: Color
@export var next_scene : String

@onready var label_text = $InteractIndicator
@onready var indicator = $InteractIndicator/IndicatorAnimation
@onready var left_anim_tree = $InteractIndicator/AnimTree_Left
@onready var right_anim_tree = $InteractIndicator/AnimTree_Right

var player_in_range = false

func _on_ready() -> void:
	label_text.label_settings.font_color = color
	label_text.text = text

func _on_area_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = true
		if side == "left":
			left_anim_tree.active = true
			left_anim_tree.set("parameters/fade_blend/blend_amount", 0.5) 
		else:
			right_anim_tree.active = true
			right_anim_tree.set("parameters/fade_bounce_right/blend_amount", 0.5)

func _on_area_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false
		if side == "left":
			left_anim_tree.set("parameters/fade_blend/blend_amount", 1.0) 
			left_anim_tree.active = false
		else:
			right_anim_tree.set("parameters/fade_bounce_right/blend_amount", 1.0)
			right_anim_tree.active = false
		indicator.play("fade_out")

		
func _input(event:InputEvent) -> void:
	if player_in_range and event.is_action_pressed("interact"):
		Global.next_scene = next_scene;
		get_tree().change_scene_to_packed(Global.loading_screen)
		
		
