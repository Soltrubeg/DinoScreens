extends CharacterBody2D

@export var speed : float = 1
@export_enum("Horizontal", "Vertical") var direction = 0

var tick : float

func _ready() -> void:
	$StaticBody2D/AnimationPlayer.speed_scale=speed
	if(direction==0):
		$StaticBody2D/AnimationPlayer.play("horizontal")
	else:
		$StaticBody2D/AnimationPlayer.play("vertical")
	
	
