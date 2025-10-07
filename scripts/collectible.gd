class_name Collectible
extends Node2D

@export var item_name : String

@onready var detector = $InteractArea
@onready var animator = $AnimationPlayer
var interactive = true

func _on_ready():
	if item_name == "Magic Orb":
		$AnimatedSprite2D.play("magic_orb")
	elif item_name == "Heart":
		$AnimatedSprite2D.play("magic_orb")
		self.modulate = Color("500418")
	elif item_name == "Magic Wand":
		$AnimatedSprite2D.play("magic_wand")
	else:
		$AnimatedSprite2D.play("default")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and interactive:
		interactive = false
		animator.play("collect")
		GameManager.inventory.add_item(item_name, 1)
