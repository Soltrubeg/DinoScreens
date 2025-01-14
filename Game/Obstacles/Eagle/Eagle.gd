extends CharacterBody2D

var tick : float

func _ready() -> void:
	$Sprite2D/AnimationPlayer.play("idle")

func _physics_process(delta: float) -> void:
	tick += 0.0166
	var yOff = sin(tick)*30
	velocity.y = yOff
	move_and_slide()
