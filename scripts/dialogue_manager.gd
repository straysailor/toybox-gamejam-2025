extends Node
var endings = [
	{
		"good":3,
		"evil":0,
		"text":"You did good!"
	},
	{
		"good":2,
		"evil":1,
		"text":"You did mostly good!"
	},
	{
		"good":1,
		"evil":2,
		"text":"You did mostly evil!"
	},
	{
		"good":0,
		"evil":2,
		"text":"You did evil!"
	}
]
var quest_data = [
	{
	"line":"empty",
	"stage": 4,
	"name":"End",
	"objective":"none",
	"number": 100
	},
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
	{"line":"evil",
	"stage": 3,
	"name":"Third Evil Quest",
	"objective":"GodotHeart",
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
	{"line":"good",
	"stage": 3,
	"name": "Third Good Quest",
	"objective":"Gemstone",
	"number": 1
	},{
		"line":"good",
		"stage":3,
		"name":"Kill Clyde",
		"objective":"ClydeHeart",
		"number": 1
	}
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
	"I need to you find a purple gemstone...", "The fox told me where it was..", "He said it hangs under three and three quarters",
	"Give it to me once you're finished", "Remember, three and three quarters.."],
	"quest":"Second Evil Quest",
	"options": ["third_evil_quest", "second_failed_evil_quest"]
	},{"id":"third_evil_quest",
	"tag": "success",
	"char":"evil", 
	"lines":["Good, when your parents wake up\nthey will join you and play with you everyday.", "Doesn’t that sound fun?", "Now we need to do one last thing\nbefore you can have everything you have ever wanted…", 
	"I need you to harvest the secret from Godot"],
	"quest":"Second Evil Quest",
	"options": ["ending"]
	},
	{"id":"first_failed_evil_quest",
	"tag": "failure",
	"char":"evil", 
	"lines":["I see you didn't care for my offer of you greatest wish...", "Don't worry, I'm generous", "You can have a second chance", "Go get those toys for me\nbefore it's too late."],
	"quest":"First Evil Quest",
	"options": ["second_evil_quest", "second_failed_evil_quest", "ending"]
	},
	{"id":"second_failed_evil_quest",
	"tag": "failure",
	"char":"evil", 
	"lines":["Ugh, what do you want\nyou goodie two shoe?", "Regret your choice of going\n with that mentally ill toy?", "I told you that he was delusional,\nnothing good will ever come from him", "But I won’t lie to you,\nI will let you have control\n over your own desires\n","So…what do you say",
	"Well…you’re not fully influenced\n by that delusional brat yet…","So you can still be useful."," I’ll still keep my promise\n about you getting what your\n heart desires",
	"I just need you\nto strike down Godot!"],
	"quest":"Third Evil Quest",
	"options": ["evil_2_end"]
	},
	{"id":"evil_2_end",
	"tag": "success",
	"char":"evil", 
	"lines":["That's very good...", "I suppose I can grant\nyou your wish after all", "You're sick of your parents\ntelling you what to do", "I know\nI hear you complain", "Let me take care\n of that for you"],
	"quest":"End",
	"options": []
	},
	{"id":"evil_1_end",
	"tag": "success",
	"char":"evil", 
	"lines":["That's very good...", "I suppose I can grant\nyou your wish after all", "You're sick of your parents\ntelling you what to do", "I know\nI hear you complain", "Let me take care\n of that for you"],
	"quest":"End",
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
	"options": ["third_good_quest", "second_failed_good_quest"]
	},
	{"id":"third_good_quest",
	"tag": "success",
	"char":"good", 
	"lines":["Great!", "With this gem, we can exorcise that old spirit", "Visit the gravestone outback", "You'll have to place the gem there\nand then we can begin\nthe ritual"],
	"quest":"Third Good Quest",
	"options": ["ending"]
	},
	{"id":"first_failed_good_quest",
	"tag": "failure",
	"char":"good", 
	"lines":["I forgive you for your betrayal", "Everyone deserves a second chance", "We still need that magic!", "Go get those orbs"],
	"quest":"First Good Quest",
	"options": ["second_good_quest", "second_failed_good_quest", "ending"]
	},
	{"id":"second_failed_good_quest",
	"tag": "failure",
	"char":"good", 
	"lines":["Ah, I was hoping it didn't have to be like this...", "You can still help me if you find the will in your heart", "I need you to strike down Clyde", "I thought we could rescue him\nthat opporunity is passed", "Go on now, and you may redeem yourself."],
	"quest":"Kill Clyde",
	"options": ["good_2_ending"]
	},
	{"id":"good_2_ending",
	"tag": "success",
	"char":"good",
	"lines":["You did the right thing in the end", "but the damage has been done", "With the power that Clyde\npossessed for even a moment,\nhe certainly reaked havoc", "I fear things will never be the same for you, kid"],
	"quest":"End",
	"options":[]
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
	if completed_quest.quest_line == "evil":
		GameManager.fail_quest(current_good_dialogue.quest)
		for d in current_evil_dialogue.next_quest:
			if d.tag=="success":
				current_evil_dialogue = d
		for d in current_good_dialogue.next_quest:
			if d.tag == "failure":
				current_good_dialogue = d
		GameManager.stage = current_evil_dialogue.quest.quest_stage
	elif completed_quest.quest_line == "good":
		GameManager.fail_quest(current_evil_dialogue.quest)
		for d in current_evil_dialogue.next_quest:
			if d.tag=="failure":
				current_evil_dialogue = d
		for d in current_good_dialogue.next_quest:
			if d.tag == "success":
				current_good_dialogue = d
		GameManager.stage = current_good_dialogue.quest.quest_stage
	else:
		dialogue_enabled = true
	print(GameManager.stage)

## INTRO DIALOGUE HANDLER
var intro_i = 0
var intro_len = len(intro_dialogue)
func get_next_intro():
	var next_dialogue = {"char":"end","lines":[]}
	if intro_i < intro_len:
		next_dialogue = intro_dialogue[intro_i]
		intro_i+=1
	return next_dialogue
