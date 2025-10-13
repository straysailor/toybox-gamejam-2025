extends Node

var inventory: Inventory = Inventory.new()
var player: PlayerVars = PlayerVars.new()
var player_spawn_side: String = "left"
var game_started = false
var completed_quest_string = []
var active_quests = []
var stage = 0
var dead_toys = []

func check_if_complete(quest)->bool:
	var quest_objective = quest.objective
	if inventory.check_for_item(quest_objective) >= quest.number:
		print("Quest complete!")
		if quest in active_quests:
			if !quest.complete:
				completed_quest_string.append(quest.quest_line)
			active_quests.erase(quest)
		DialogueManager.advance_quest_stage(quest)
		return true
	return false

func complete_quest(quest_name:String)->void:
	var quest = check_active(quest_name)
	if quest != null:
		quest.complete = true
		completed_quest_string.append(quest.quest_line)
		active_quests.erase(quest)
		DialogueManager.advance_quest_stage(quest)

func add_active_quest(quest:QuestData) -> void:
	if quest not in active_quests:
		active_quests.append(quest)
		
func fail_quest(quest:QuestData)->void:
	if quest in active_quests:
		active_quests.erase(quest)
func check_active(quest_name:String):
	for quest in active_quests:
		if quest.quest_name == quest_name:
			return quest
	return null
func enable_collectibles(quest_name:String)->bool:
	print(active_quests)
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

func get_ending()->String:
	var g_count = completed_quest_string.count("good")
	print(completed_quest_string)
	if g_count == 3:
		return "You did good"
	elif g_count == 2:
		return "You did mostly good"
	elif g_count == 1:
		return "You did mostly evil"
	else:
		return "You did evil"

func end_game():
	Global.next_scene = "res://scenes/end.tscn";
	get_tree().change_scene_to_packed(Global.loading_screen)
