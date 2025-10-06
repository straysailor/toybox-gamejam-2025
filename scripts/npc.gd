class_name NPC
extends Node2D

@export var char_name : String

@onready var indicator = $InteractIndicator/AnimationPlayer
@onready var text = $InteractIndicator

var player_in_range = false
var text_default = "Speak\nv"
var next_text = ""
var dialogue = null

func _ready() -> void:
	dialogue = DialogueManager.get_dialogue(char_name)
	next_text = dialogue.next_dialogue()
	if char_name == "evil":
		$AnimatedSprite2D.play("evil_cat")
	else:
		$AnimatedSprite2D.play("default")
	
func _on_interact_area_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = true
		indicator.play("fade_text")

func _on_interact_area_exited(body: Node2D) -> void:
	if body.name == "Player":
		text.text = text_default
		player_in_range = false
		indicator.stop(false)
		
func _input(event: InputEvent) -> void:
	if player_in_range and event.is_action_pressed("interact"):
		indicator.stop(false)
		text.label_settings.font_color = Color(255.0, 255.0, 255.0, 1.0)
		text.text = next_text + "\nv"
		handle_dialogue()

func handle_dialogue() -> void:
	next_text = dialogue.next_dialogue()
	if dialogue.check_fulfilled():
		dialogue = DialogueManager.get_dialogue(char_name)
		next_text = dialogue.next_dialogue()
	
