extends Node

var quests = []
var evil_dialogue_data = [
	{"id":"first_evil_quest",
	"char":"evil", 
	"lines":["Hello", "Welcome to the world", "Let's get started"],
	"quest":"First Evil Quest",
	"options": ["second_evil_quest","first_failed_evil_quest"]
	},
	{"id":"second_evil_quest",
	"char":"evil", 
	"lines":["Nice going", "Let's get to our second quest", "Here's the plan:"],
	"quest":"Second Evil Quest",
	"options": []
	},
	{"id":"first_failed_evil_quest",
	"char":"evil", 
	"lines":["I see you didn't care for my first offer", "Don't worry, we can fix that", "Next quest"],
	"quest":"First Quest",
	"options": []
	}
]

var current_evil_dialogue : DialogueData = DialogueData.new("null","evil",[],QuestData.new())
var current_good_dialogue : DialogueData = DialogueData.new("null","evil",[],QuestData.new())

func create_dialogue(dialogue:Dictionary, dialogue_data:Array)->DialogueData:
	var new_dialogue = DialogueData.new(dialogue.get("id"), dialogue.get("char"), dialogue.get("lines"), QuestData.new())
	var next_options = []
	for option in dialogue.get("options"):
		for d in dialogue_data:
			if d.get("id") == option:
				next_options.append(create_dialogue(d, dialogue_data))
	new_dialogue.next_quest = next_options
	return new_dialogue
	
func set_up_dialogue():
	current_evil_dialogue = create_dialogue(evil_dialogue_data[0], evil_dialogue_data)
	print("The current dialogue:", current_evil_dialogue)
	print("The lines: ", current_evil_dialogue.dialogue_lines)
	print("Next quest: ",current_evil_dialogue.next_quest)
	
func get_dialogue(character_name:String) -> DialogueData:
	if character_name == "evil":
		return current_evil_dialogue
	return null
