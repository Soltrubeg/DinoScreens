extends Node2D

@onready var camera : Camera2D = get_node("Camera")
@onready var player : CharacterBody2D = get_node("Player")
@onready var character = Global.characters.values()[Global.selected_character]

@onready var rooms = Global.rooms

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused=false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	Global.current_room = get_node("Start Screen")
	Global.room = 0
	Global.start_time = -1
	Global.lives_left = character.lives
	
func _on_player_pass_through_door() -> void:
	Global.room += 1
	if(Global.room==1): Global.start_time = Time.get_ticks_msec()
	var next_room : PackedScene = rooms[randi() % rooms.size()]
	var instance : Node2D = next_room.instantiate()
	instance.position.x = Global.room * 640
	player.position.x = (Global.room * 640) + 20
	Global.spawn_pos = player.position
	camera.position.x += 640
	add_child(instance)
	var wall : StaticBody2D = preload("res://Scenes/wall.tscn").instantiate()
	wall.position.x = -10
	$HUD/Background.scroll_base_offset = Vector2(randf_range(0,640),0)
	instance.add_child(wall)
	
	await get_tree().create_timer(1.6).timeout
	Global.current_room.queue_free()
	Global.current_room = instance


func _on_player_death() -> void:
	add_child(preload("res://death_screen.tscn").instantiate())
