extends CharacterBody2D

@export var speed : float = 1
@export var horizontal : bool = false

var tick : float

func _ready() -> void:
	$StaticBody2D/AnimationPlayer.speed_scale=speed
	if(horizontal):
		$StaticBody2D/AnimationPlayer.play("horizontal")
	else:
		$StaticBody2D/AnimationPlayer.play("vertical")
	
	
