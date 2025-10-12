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
	"objective":"Gemstone",
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
	"objective":"Gemstone",
	"number": 1
	},
]
var intro_dialogue = [{
	"char": "Clyde the Cat",
	"lines":["..."]
},{
	"char": "Robo Godot",
	"lines":["..."]
},{
	"char": "Kid",
	"lines":["..."]
},{
	"char": "Robo Godot",
	"lines":["I think he sees us.."]
},{
	"char": "Clyde the Cat",
	"lines":["Shush"]
},
{
	"char": "Kid",
	"lines":["..."]
},
{
	"char": "Clyde the Cat",
	"lines":["...Ugh, I can’t take this anymore!", "I’m in a terrible position to be playing fake. My yarns feel too old to be doing stealth anymore…"]
},{
	"char": "Robo Godot",
	"lines":["Well…now that the cat’s out of the bag…thanks to you."]
},
{
	"char": "Clyde the Cat",
	"lines":["Tsk!"]
},
{
	"char": "Robo Godot",
	"lines":[" Anyways, it’s been too long of a time!", "I’ve always wondered what you’d look like! And you look as kind as I had imagined!", "Even though we’ve been with you this entire time, I couldn’t get a good look at you until now!
"]
},
{
	"char":"Clyde the Cat",
	"lines":["We’ve had consciousness but not an actual eye nor the ability to meet you like this.", "Do you remember when your mom had to sew one of my eyes with a button because you were too rough with me?",
	"Guess what? I now have what's called a 'Faery Eye', I should be thanking you."]
},
{
	"char": "Kid",
	"lines":["What does it do...?"]
},
{
	"char": "Clyde the Cat",
	"lines":["It allows me to discern between lies and truths, meaning that I can piece together what you wish for!", "Kind of like those wish granting stars!"]
}, 
{
	"char": "Robo Godot",
	"lines":["Don’t be tainted by his charming words!","I am the hero of the toys and I am the protector which you had me sworn to protect each and every toy!"
	,"You can be my right-hand man in saving all the toys!", "We should chat- in private."]
}
]
var evil_dialogue_data = [
	{"id":"first_evil_quest",
	"tag": "success",
	"char":"evil", 
	"lines":["Good", "I’ll make sure you’re well compensated\nby the end of this farce", "Now I need you to go around the house\nand poke the other toys with your\nMagical Wand",
	"Don’t worry about hurting them, they won’t feel a thing", "They've been hiding secrets from you", "Collect at least 3 of these secrets for me"],
	"quest":"First Evil Quest",
	"options": ["second_evil_quest","first_failed_evil_quest"]
	},
	{"id":"second_evil_quest",
	"tag": "success",
	"char":"evil", 
	"lines":["Great job kid", "Let’s see if Godot will like this present for him", "But before that I need you to relinquish your heart\nby letting you out of your cage", 
	"Go find your parents and give them a bonk with your Magical Wand", "I promise they won’t nag you about it and they’ll have fun like you do."],
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
	"lines":["Ah thank goodness for choosing to help me", "First, we need to get rid of the evil before us", "To do that I need you to collect magic around the house", "I sense it's stirred around the house", "Go collect me at least 3 orbs!"],
	"quest":"First Good Quest",
	"options": ["second_good_quest","first_failed_good_quest"]
	},
	{"id":"second_good_quest",
	"tag": "success",
	"char":"good", 
	"lines":["Great!", "Now that we have enough “Magic” charged into your Wand, I need one more thing", "I've never seen it before personally", "but the fox told me!", "He said it hangs under three and three quarters"],
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

var dialogue_enabled : bool = false
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
	GameManager.stage += 1
	if completed_quest.quest_line == "evil":
		for d in current_evil_dialogue.next_quest:
			if d.tag=="success":
				current_evil_dialogue = d
		for d in current_good_dialogue.next_quest:
			if d.tag == "failure":
				current_good_dialogue = d
	elif completed_quest.quest_line == "good":
		for d in current_evil_dialogue.next_quest:
			if d.tag=="failure":
				current_evil_dialogue = d
		for d in current_good_dialogue.next_quest:
			if d.tag == "success":
				current_good_dialogue = d
	else:
		dialogue_enabled = true

## INTRO DIALOGUE HANDLER
var intro_i = 0
var intro_len = len(intro_dialogue)
func get_next_intro():
	var next_dialogue = {"char":"end","lines":[]}
	if intro_i < intro_len:
		next_dialogue = intro_dialogue[intro_i]
		intro_i+=1
	return next_dialogue
