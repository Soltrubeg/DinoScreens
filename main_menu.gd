extends Control

var tick : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused=false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	update_menu()
	$MarginContainer/SplitContainer/Buttons/Play.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	tick += delta
	var name_scale = (sin(tick*5)+1) / 8 + 1
	$DinoName.scale = Vector2(name_scale,name_scale)


func _on_prev_dino_button_down() -> void:
	Global.selected_character -= 1
	Global.selected_character = wrap(Global.selected_character, 0, Global.characters.size())
	update_menu()
	$ClickButton.play()
	
func _on_next_dino_button_down() -> void:
	Global.selected_character += 1
	Global.selected_character = wrap(Global.selected_character, 0, Global.characters.size())
	update_menu()
	$ClickButton.play()
	
func update_menu():
	$MarginContainer/DinoSprite.texture = Global.characters.values()[Global.selected_character].sprite_sheet
	$DinoName.text = Global.characters.keys()[Global.selected_character]


func _on_play_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_exit_button_down() -> void:
	get_tree().quit()
