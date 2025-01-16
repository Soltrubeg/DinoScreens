extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Control/MarginContainer/MarginContainer/HBoxContainer/Restart.grab_focus()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused=true
	set_process_input(false)
	
	var labels = $Control/MarginContainer/MarginContainer/VBoxContainer
	labels.get_node("Character").text="[left]Character[color=#8f8f8f]....................[/color]" + Global.characters.keys()[Global.selected_character]
	labels.get_node("Score").text="[left]Score[color=#8f8f8f]...............................[/color]" + str(Global.room)
	labels.get_node("Time").text="[left]Time passed[color=#8f8f8f].............[/color]" + get_time()
	labels.get_node("AvgTime").text="[left]Average time[color=#8f8f8f]...........[/color]" + get_avg_time()


func get_time():
	if(Global.start_time==-1):
		return "0:00"
	var current_time = Time.get_ticks_msec() - Global.start_time
	var minutes = current_time/1000/60
	var seconds = current_time/1000%60
	return str(minutes)+":"+str(seconds).pad_zeros(2)
	
func get_avg_time():
	if(Global.start_time==-1):
		return "0:00"
	var current_time = (Time.get_ticks_msec() - Global.start_time) / Global.room
	var minutes = current_time/1000/60
	var seconds = current_time/1000%60
	return str(minutes)+":"+str(seconds).pad_zeros(2)


func _on_restart_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_menu_button_down() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name=="fade_in"):
		$Control/MarginContainer/MarginContainer/HBoxContainer/Restart.process_mode=Node.PROCESS_MODE_INHERIT
		$Control/MarginContainer/MarginContainer/HBoxContainer/Menu.process_mode=Node.PROCESS_MODE_INHERIT
