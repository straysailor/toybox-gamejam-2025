class_name Inventory

@export var id: String
@export var inventory : Dictionary

func add_item(name, number):
	var count = inventory.get(name)
	if count:
		inventory.set(name, number + count)
	else:
		inventory.set(name, number)
	
func check_for_item(name):
	print(inventory.get(name))
