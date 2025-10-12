extends Node2D

@onready var anim_player = $AnimationPlayer
@onready var gem_sprite = $GemSprite
var collectible = load("res://scenes/collectible.tscn")
var clock_selected = false
var hour_phases = ["hour_1","hour_3","hour_5","hour_6","hour_7","hour_9","hour_11","hour_12"]
var minute_phases = ["min_5", "min_15", "min_25", "min_30", "min_35", "min_45", "min_55", "min_0"]
var hour_pos = 0
var min_pos = 0
var quest_active = false
var clock_locked = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameManager.stage == 2:
		quest_active = true
	if GameManager.stage == 3 or GameManager.inventory.check_for_item("Gemstone") > 0:
		clock_locked = true
		gem_sprite.visible = false

func _on_clockface_mouse_entered() -> void:
	clock_selected = true
	
func drop_gem() -> void:
	anim_player.queue("drop_gem")
	
func check_complete() -> bool:
	if quest_active:
		if hour_pos == 2 and min_pos == 6:
			drop_gem()
			return true
	return false

func _on_clockface_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if clock_selected and !clock_locked:
		if event.is_action_pressed("interact"):
			anim_player.play(hour_phases[hour_pos])
			hour_pos+=1
			if hour_pos >= len(hour_phases):
				hour_pos = 0
			clock_locked = check_complete()
		if event.is_action_pressed("secondary_interact"):
			anim_player.play(minute_phases[min_pos])
			min_pos+=1
			if min_pos >= len(hour_phases):
				min_pos = 0
			clock_locked = check_complete()



func _on_clockface_mouse_exited() -> void:
	clock_selected = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "drop_gem":
			var gem = collectible.instantiate()
			gem.item_name = "Gemstone"
			gem.position.x = gem_sprite.position.x
			gem.position.y = gem_sprite.position.y
			gem.rotation = gem_sprite.rotation
			gem.scale.x = 2
			gem.scale.y = 2
			self.add_child(gem)
			gem_sprite.visible = false
