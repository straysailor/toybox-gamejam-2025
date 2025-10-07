extends Node2D

var collectible = load("res://scenes/collectible.tscn")

func _ready() -> void:
	if !GameManager.game_started or GameManager.inventory.check_for_item("Magic Wand") == -1:
		var magic_wand = collectible.instantiate()
		magic_wand.item_name = "Magic Wand"
		magic_wand.position.x = 1434
		magic_wand.position.y = 482
		self.add_child(magic_wand)
		GameManager.game_started = true
