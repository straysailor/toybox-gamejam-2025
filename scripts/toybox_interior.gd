extends Node2D

@onready var player = $RoomLayout/Player

var climb_speed = 600
var dialogue_box = load("res://scenes/dialogue_box.tscn")
var dialogue
var dialogue_open = false

func _on_box_touched(body: Node2D) -> void:
	if body.name == "Player":
		player.climb_speed = climb_speed


func _on_box_left(body: Node2D) -> void:
	if body.name == "Player":
		player.climb_speed = 0


func _on_ready() -> void:
	if GameManager.stage == 0:
		var new_dialogue = dialogue_box.instantiate()
		new_dialogue.name = "DialogueBox"
		new_dialogue.speaker_name = "Kid"
		new_dialogue.body_text = "..."
		new_dialogue.position.x = 400
		new_dialogue.position.y = 500
		self.add_child(new_dialogue)
		dialogue_open = true
		dialogue = new_dialogue
		player.can_move = false
		
var intro_dialogue
var index = 0
func _process(_delta: float) -> void:
	if dialogue_open:
		if Input.is_action_just_pressed("interact"):
			if intro_dialogue:
				if intro_dialogue.char !="end" and dialogue:
					handle_dialogue()
					dialogue.update_text()
			else:
				intro_dialogue = DialogueManager.get_next_intro()
				
func handle_dialogue():
	if intro_dialogue and index < len(intro_dialogue.lines):
		print(intro_dialogue.char, intro_dialogue.lines[index])
		dialogue.speaker_name = intro_dialogue.char
		dialogue.body_text = intro_dialogue.lines[index]
		index+=1
	else:
		index = 0
		intro_dialogue = DialogueManager.get_next_intro()
		if intro_dialogue.char != "end":
			print(intro_dialogue.char, intro_dialogue.lines[index])
			dialogue.speaker_name = intro_dialogue.char
			dialogue.body_text = intro_dialogue.lines[index]
			index+=1
		else:
			if dialogue:
				dialogue_open = false
				self.remove_child(dialogue)
				GameManager.stage = 1
				player.can_move = true
		
		
