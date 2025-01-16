extends Node

var room : int
var start_time : int

var current_room : Node2D
var spawn_pos : Vector2
var room_y : float
var camera_y : float
var lives_left : int

var selected_character := 0

var cursor = preload("res://Cursors/default.png")
var cursor_hand = preload("res://Cursors/interactable.png")

var characters := {
	"Doux" : load("res://Player/Characters/doux.tres"),
	"Mort" : load("res://Player/Characters/mort.tres"),
	"Tard" : load("res://Player/Characters/tard.tres"),
	"Vita" : load("res://Player/Characters/vita.tres"),
}

var rooms = [
	
	preload("res://Screens/Screen1.tscn"),
	preload("res://Screens/Screen2.tscn"),
	preload("res://Screens/Screen3.tscn"),
	preload("res://Screens/Screen4.tscn"),
	preload("res://Screens/Screen5.tscn"),
	preload("res://Screens/Screen6.tscn"),
	preload("res://Screens/Screen7.tscn"),
	
]

func _ready() -> void:
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(0,0))
	Input.set_custom_mouse_cursor(cursor_hand, Input.CURSOR_POINTING_HAND, Vector2(0,0))
