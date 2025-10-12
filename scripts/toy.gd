extends Node2D

@export var toy_type : String = "default"

@onready var sprite = $sprite/AnimatedSprite2D
@onready var anim_player = $AnimationPlayer

var collectible = load("res://scenes/collectible.tscn")
var interactive = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play(toy_type)



func _on_toy_interact(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("secondary_interact") and interactive:
		kill_toy()

func kill_toy() -> void:
	anim_player.play("death")
	interactive = false
	var heart = collectible.instantiate()
	heart.name = "Heart"
	heart.item_name = "Heart"
	heart.position.x = 0
	heart.position.y = 0
	self.add_child(heart)
