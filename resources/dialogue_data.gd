class_name DialogueData
extends Resource

@export var id: String
@export var npc_name : String
@export var tracker : int = 0
@export var dialogue_lines : Array = ["Hello"]
@export var quest : QuestData
@export var next_quest: Array

func _init(id:String, npc_name:String, lines:Array, quest:QuestData) -> void:
	id=id
	npc_name=npc_name
	dialogue_lines=lines
	quest=quest
	
func next_dialogue()->String:
	var next = dialogue_lines[tracker]
	if tracker < len(dialogue_lines) - 1:
		tracker = tracker + 1
	return next

func check_fulfilled()->void:
	if quest.check_complete():
		pass
		## Load next dialogue somewhere accessible
	else:
		pass
		## Load alternative dialogue
		
