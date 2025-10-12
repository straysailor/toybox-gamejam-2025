extends Control

@export var speaker_name: String
@export var body_text : String

@onready var speaker = $SpeakerCont/SpeakerLabel
@onready var body = $MarginContainer/BodyCont/DialogueText
@onready var anim_player = $AnimationPlayer

func _ready() -> void:
	body.visible_ratio = 0
	speaker.text = speaker_name
	body.text = body_text
	anim_player.play("load_text")


func update_text():
	speaker.text = speaker_name
	body.text = body_text
	anim_player.play("load_text")
