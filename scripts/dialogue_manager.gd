extends Node

var quest_data = [
	{"line":"evil",
	"stage": 1,
	"name":"First Evil Quest",
	"objective":"Heart",
	"number": 3
	},
	{"line":"evil",
	"stage": 2,
	"name":"Second Evil Quest",
	"objective":"Puzzle",
	"number": 1
	},
	{"line":"good",
	"stage": 1,
	"name":"First Good Quest",
	"objective":"Magic Orb",
	"number": 3
	},
	{"line":"good",
	"stage": 2,
	"name":"Second Good Quest",
	"objective":"Puzzle 2",
	"number": 1
	},
]
var evil_dialogue_data = [
	{"id":"first_evil_quest",
	"tag": "success",
	"char":"evil", 
	"lines":["Hello", "Welcome to the world", "Let's get started"],
	"quest":"First Evil Quest",
	"options": ["second_evil_quest","first_failed_evil_quest"]
	},
	{"id":"second_evil_quest",
	"tag": "success",
	"char":"evil", 
	"lines":["Nice going", "Let's get to our second quest", "Here's the plan:"],
	"quest":"Second Evil Quest",
	"options": []
	},
	{"id":"first_failed_evil_quest",
	"tag": "failure",
	"char":"evil", 
	"lines":["I see you didn't care for my first offer", "Don't worry, we can fix that", "Next quest"],
	"quest":"Second Evil Quest",
	"options": []
	}
]
var good_dialogue_data = [
	{"id":"first_good_quest",
	"tag": "success",
	"char":"good", 
	"lines":["Good day!", "Welcome to my game!", "Let's Play"],
	"quest":"First Good Quest",
	"options": ["second_good_quest","first_failed_good_quest"]
	},
	{"id":"second_good_quest",
	"tag": "success",
	"char":"good", 
	"lines":["Wonderful!", "Let's get move on", "I believe you can do this:"],
	"quest":"Second Good Quest",
	"options": []
	},
	{"id":"first_failed_good_quest",
	"tag": "failure",
	"char":"good", 
	"lines":["I forgive you for your betrayal", "Everyone deserves a second chance"],
	"quest":"Second Good Quest",
	"options": []
	}
]

var current_evil_dialogue : DialogueData 
var current_good_dialogue : DialogueData

var quests:Array[QuestData] = []

func create_dialogue(dialogue:Dictionary, dialogue_data:Array)->DialogueData:
	var assigned_quest : QuestData
	if len(quests) > 0:
		for quest in quests:
			if dialogue.get("quest") == quest.quest_name:
				assigned_quest = quest
	if !assigned_quest:
		for quest in quest_data:
			if quest.get("name") == dialogue.get("quest"):
				assigned_quest = QuestData.new(
				quest.line,
				quest.name,
				quest.stage,
				quest.objective,
				quest.number
			)
				quests.append(assigned_quest)
	var new_dialogue = DialogueData.new(dialogue.get("id"), dialogue.get("char"), dialogue.get("lines"), assigned_quest, dialogue.get("tag"))
	var next_options = []
	for option in dialogue.get("options"):
		for d in dialogue_data:
			if d.get("id") == option:
				next_options.append(create_dialogue(d, dialogue_data))
	new_dialogue.next_quest = next_options
	return new_dialogue
	
func set_up_dialogue():
	current_evil_dialogue = create_dialogue(evil_dialogue_data[0], evil_dialogue_data)
	current_good_dialogue = create_dialogue(good_dialogue_data[0], good_dialogue_data)
	
func get_dialogue(character_name:String) -> DialogueData:
	if character_name == "evil":
		return current_evil_dialogue
	elif character_name == "good":
		return current_good_dialogue
	return null

func advance_quest_stage(completed_quest: QuestData)->void:
	print("Advancing the quest stage!")
	if completed_quest.quest_line == "evil":
		for d in current_evil_dialogue.next_quest:
			if d.tag=="success":
				current_evil_dialogue = d
		for d in current_good_dialogue.next_quest:
			if d.tag == "failure":
				current_good_dialogue = d
	else:
		for d in current_evil_dialogue.next_quest:
			if d.tag=="failure":
				current_evil_dialogue = d
		for d in current_good_dialogue.next_quest:
			if d.tag == "success":
				current_good_dialogue = d
