extends CharacterBody2D

@onready var pos := position
@onready var can_fall := true
@onready var falling := false

func _physics_process(delta: float) -> void:
	if(falling): position.y+=200*delta


func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.is_in_group("Player")):
		if(can_fall):
			$AnimationPlayer.play("fall")
			


func _on_timer_timeout() -> void:
	scale = Vector2(0,0)
	$AnimationPlayer.play("spawn")
	position=pos
	falling=false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name=="fall"):
		can_fall=false
		falling=true
		$Timer.start()
	if(anim_name=="spawn"): can_fall=true
