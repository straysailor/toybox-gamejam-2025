extends Node2D
var collectible = load("res://scenes/collectible.tscn")
var rng = RandomNumberGenerator.new()
var collectibles_enabled = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collectibles_enabled = GameManager.enable_collectibles("First Good Quest")
	if collectibles_enabled:
		for i in range(0, 3):
			var new_item = collectible.instantiate()
			new_item.item_name = "Magic Orb"
			new_item.position.x = rng.randi_range(500, 2000)
			new_item.position.y = rng.randi_range(-60, 100)
			self.add_child(new_item)
