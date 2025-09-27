extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.next_scene != "Null":
		print(Global.next_scene)
		ResourceLoader.load_threaded_request(Global.next_scene)
	else:
		print("Scene does not exist")
		Global.next_scene = "res://scenes/main_menu.tscn"
		ResourceLoader.load_threaded_request(Global.next_scene)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var progress = []
	ResourceLoader.load_threaded_get_status(Global.next_scene, progress)
	$ProgressBar.value = progress[0]*100
	
	if progress[0] == 1:
		var loaded_scene = ResourceLoader.load_threaded_get(Global.next_scene)
		get_tree().change_scene_to_packed(loaded_scene)
