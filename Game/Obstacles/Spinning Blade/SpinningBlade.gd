extends CharacterBody2D
@export var follow_speed: float = 2

func _physics_process(delta: float) -> void:
	$Path2D/PathFollow2D.progress += follow_speed

	move_and_slide()
