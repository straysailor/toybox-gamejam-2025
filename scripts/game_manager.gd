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
	if g_count == 3:
		return "After cleansing the grave, it felt as if a weight had been lifted from your shoulders.
		 Clyde's personality changed to be friendlier. Life went on
		as usual for a while. You found yourself spending more time talking to your plushes than your friends and family.
		None of them were able to speak to the toys like you were. Rumors began ciculating that you had lost your mind...
		but you didn't care. You were happy, and that's all that mattered..."
	elif g_count == 2:
		return "You were doing so well…until you were tainted with the possibilities that Clyde had for you. 
		But in the end you still got what you had wanted, so why does it matter?"
	elif g_count == 1:
		return "With Godot's words echoing in your mind, you left the toybox to find all was not as you thought it had been.
		Pots and pans piled high in the sink, dust and cobwebs accumulated in corners. The place felt empty- as if no one had been there for a while.
		You checked the backyard, walking up to the old grave. The words inscribed there finally seemed legible. To your 
		horror, they read Mom and Dad 1987 - 2025."
	else:
		return "You find your vision darkening as Clyde rises from the corner he was sitting in. 
		The police soon arrive at the house and find the kid in the middle of their destroyed toys, laughing  to themselves, 
		while in another room the kids parents are sprawled across the floor, pale and lifeless with no clear cause of injury..."

func end_game():
	Global.next_scene = "res://scenes/end.tscn";
	get_tree().change_scene_to_packed(Global.loading_screen)
