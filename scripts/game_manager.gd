extends Node

var inventory: Inventory = Inventory.new()
var player: PlayerVars = PlayerVars.new()
var player_spawn_side: String = "left"

func check_if_complete(quest)->bool:
	var quest_objective = quest.objective
	print("The objective: ", quest_objective)
	print("Player's inventory: ", inventory.check_for_item(quest_objective))
	if inventory.check_for_item(quest_objective) >= quest.number:
		print("Quest complete!")
		DialogueManager.advance_quest_stage(quest)
		return true
	return false
