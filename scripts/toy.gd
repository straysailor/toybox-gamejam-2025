extends Node2D

@export var toy_name : String = ""
@export var toy_type : String = "default"
@export var flipped : bool = false

@onready var sprite = $sprite/AnimatedSprite2D
@onready var anim_player = $AnimationPlayer

var collectible = load("res://scenes/collectible.tscn")
var interactive = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if flipped:
		sprite.flip_h = flipped
	sprite.play(toy_type)
	if toy_name == "":
		toy_name = toy_type
	if GameManager.check_dead(toy_name):
		self.visible = false



func _on_toy_interact(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("secondary_interact"):
		if !interactive:
			interactive = GameManager.enable_collectibles("First Evil Quest")
		if interactive:
			kill_toy()

func kill_toy() -> void:
	GameManager.register_death(toy_name)
	anim_player.play("death")
	interactive = false
	var heart = collectible.instantiate()
	heart.name = "Heart"
	heart.item_name = "Heart"
	heart.position.x = 0
	heart.position.y = 0
	self.add_child(heart)
