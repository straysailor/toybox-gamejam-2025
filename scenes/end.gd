extends Control

var end
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var g_count = GameManager.completed_quest_string.count("good")
	if g_count == 3:
		$GoodBG.visible = true
	elif g_count == 2:
		$PartGoodBG.visible = true
	elif g_count == 1:
		$PartEvilBG.visible = true
	else:
		$EvilBG.visible = true
	end = GameManager.get_ending()
	$"Ending Text".text = end
