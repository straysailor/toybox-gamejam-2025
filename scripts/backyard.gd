extends Node2D

var collectible = load("res://scenes/collectible.tscn")
@onready var grave_sprite = $"Corrupt Grave/AnimatedSprite2D"
@onready var gem_sprite = $GemSprite

var gem_inserted = false
func _ready() -> void:
	if !GameManager.game_started or GameManager.inventory.check_for_item("Magic Wand") == -1:
		var magic_wand = collectible.instantiate()
		magic_wand.item_name = "Magic Wand"
		magic_wand.position.x = 1434
		magic_wand.position.y = 482
		self.add_child(magic_wand)
		GameManager.game_started = true
	if GameManager.stage == 3:
		grave_sprite.visible = true
		grave_sprite.play("default")


func _on_grave_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("interact"):
		if GameManager.inventory.check_for_item("Gemstone") > 0 and GameManager.enable_collectibles("Third Good Quest"):
			gem_inserted = true
			grave_sprite.visible = true
			gem_sprite.modulate = Color("ffffff")
			grave_sprite.play("default")
			exorcise_grave()

func exorcise_grave():
	$RoomLayout.left_exit = "dead_end"
	GameManager.complete_quest("Third Good Quest")
	GameManager.end_game()
