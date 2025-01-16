extends CharacterBody2D

var ready_to := true

func _physics_process(delta: float) -> void:
	
	if($RayCast2D.get_collider()  && $RayCast2D.get_collider().is_in_group("Player") && ready_to):
		$AnimationPlayer.play("activate")
		ready_to=false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name=="activate"): ready_to=true
