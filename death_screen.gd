extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused=true
	
	var labels = $Control/MarginContainer/MarginContainer/VBoxContainer
	labels.get_node("Score").text="[left]Score[color=#8f8f8f]...............................[/color]" + str(Global.room)
	labels.get_node("Time").text="[left]Time passed[color=#8f8f8f].............[/color]" + get_time()


func get_time():
	if(Global.start_time==-1):
		return "0:00"
	var current_time = Time.get_ticks_msec() - Global.start_time
	var minutes = current_time/1000/60
	var seconds = current_time/1000%60
	return str(minutes)+":"+str(seconds).pad_zeros(2)


func _on_restart_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_menu_button_down() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
