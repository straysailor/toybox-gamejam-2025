class_name QuestData
extends Resource

@export var quest_line : String
@export var quest_name : String
@export var quest_stage : int
@export var objective: String
@export var number: int
@export var accepted: bool = false

func _init(line: String, name: String, stage: int, obj: String, num: int):
	quest_line=line
	quest_name=name
	quest_stage=stage
	objective=obj
	number=num

func check_complete() -> bool:
	if GameManager.inventory.check_for_item(objective) == number:
		return true
	return false

func accept_quest() -> void:
	accepted = true
	GameManager.add_active_quest(self)
