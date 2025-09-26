extends Node

var inventory: Inventory = Inventory.new()
var player: PlayerVars = PlayerVars.new()

#func add_player_objective(objective_name)->void:
	#player.in_progress_objectives.append(objective_name)
#
#func complete_objective(objective_name)->void:
	#player.completed_objective.append(objective_name)
#
#func check_if_complete(char_name, objective)->bool:
	#var conds = DialogueManager.get(char_name).get(objective).get("conditions")
	#var type = conds.get("type")
	#if type == "fetch":
		#var found_item = inventory.check_for_item(conds.get("name"))
		#if found_item and found_item == conds.get("complete_condition"):
			#return true
	#return false
#
#func quest_started(objective)->bool:
	#if player.star
