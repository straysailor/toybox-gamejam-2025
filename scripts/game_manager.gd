extends Node

var inventory: Inventory = Inventory.new()
var player: PlayerVars = PlayerVars.new()
var player_spawn_side: String = "left"
var game_started = false
var active_quests = []
var stage = 0
var dead_toys = []

func check_if_complete(quest)->bool:
	var quest_objective = quest.objective
	print("The objective: ", quest_objective)
	print("Player's inventory: ", inventory.check_for_item(quest_objective))
	if inventory.check_for_item(quest_objective) >= quest.number:
		print("Quest complete!")
		if quest in active_quests:
			active_quests.erase(quest)
		DialogueManager.advance_quest_stage(quest)
		return true
	return false

func add_active_quest(quest:QuestData) -> void:
	if quest not in active_quests:
		active_quests.append(quest)

func enable_collectibles(quest_name:String)->bool:
	for quest in active_quests:
		if quest.quest_name == quest_name:
			return true
	return false
	
func register_death(toy_name:String)->void:
	dead_toys.append(toy_name)
func check_dead(toy_name:String)->bool:
	if toy_name in dead_toys:
		return true
	return false
func set_up_game()->void:
	inventory = Inventory.new()
	player = PlayerVars.new()
	player_spawn_side = "left"
	print(game_started)
	active_quests = [QuestData.new("start", "First Quest", 0,"Magic Wand",1)]

	
