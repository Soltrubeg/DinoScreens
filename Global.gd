extends Node

var room : int
var score : float

var current_room : Node2D
var spawn_pos : Vector2
var lives_left : int

var selected_character := 0

var characters := {
	"Doux" : load("res://Player/Characters/doux.tres"),
	"Mort" : load("res://Player/Characters/mort.tres"),
	"Tard" : load("res://Player/Characters/tard.tres"),
	"Vita" : load("res://Player/Characters/vita.tres"),
}

var rooms = [
	
	preload("res://Screens/Screen1.tscn"),
	preload("res://Screens/Screen2.tscn"),
	
]
