class_name DialogueData
extends Resource

@export var id: String
@export var npc_name : String
@export var tag: String
@export var tracker : int = 0
@export var dialogue_lines : Array = ["Hello"]
@export var quest : QuestData
@export var next_quest: Array
@export var quest_active : bool = false

func _init(d_id:String, npc:String, lines:Array, quest_obj:QuestData, d_tag:String) -> void:
	id=d_id
	npc_name=npc
	dialogue_lines=lines
	quest=quest_obj
	tag=d_tag
	
func next_dialogue()->String:
	var next = dialogue_lines[tracker]
	if tracker < len(dialogue_lines) - 1:
		tracker = tracker + 1
	else:
		print("The quest is on!")
		quest_active = true
	return next
	
func check_updated()-> bool:
	if quest.get_stage() != GameManager.stage:
		return true
	return false
func check_fulfilled()->bool:
	print("Checking if the quest has been fulfilled")
	if quest_active:
		return GameManager.check_if_complete(quest)
	return false
