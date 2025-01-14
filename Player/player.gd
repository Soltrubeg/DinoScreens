extends CharacterBody2D

@onready var character = Global.characters.values()[Global.selected_character]

@export var coyote_time = 0.1
var coyote_timer: float = 0

var prevVelocity : Vector2

signal pass_through_door
signal hurt
signal death

func _ready() -> void:
	var sprite = character.sprite_sheet
	$Sprite2D.texture=sprite
	
func _process(delta: float) -> void:
	if(is_on_floor()):
		coyote_timer=coyote_time
	else:
		coyote_timer -= delta

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	# Add the gravity.
	if is_on_floor():
		prevVelocity = Vector2(0,0)
	else:
		velocity += get_gravity() * delta
		velocity.x = lerp(prevVelocity.x, velocity.x, 0.1)
		velocity.y = lerp(prevVelocity.y, velocity.y, 0.8)
		prevVelocity = velocity
		$Sprite2D/AnimationPlayer.play("jump")

	# Handle jump.
	if Input.is_action_just_pressed("movement_jump") and coyote_timer > 0:
		coyote_timer=0
		$AudioStreamPlayer.stream = load("res://Player/Sounds/jump" + str(randi() % 3 + 1) + ".mp3")
		$AudioStreamPlayer.volume_db = 0
		$AudioStreamPlayer.play()
		velocity.y = -character.jump_strength
	
	if Input.is_action_just_released("movement_jump") and velocity.y<0:
		velocity.y *= 0.4

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("movement_left", "movement_right")
	var looking_direction:= Input.get_axis("look_left","look_right")
	var crouching := Input.get_action_strength("movement_crouch")
	if direction:
		velocity.x = direction * character.movement_speed
	else:
		velocity.x = move_toward(velocity.x, 0, character.movement_speed)
	
	if(!looking_direction):
		looking_direction = direction
	if(looking_direction > 0):
		$Sprite2D.flip_h=false
	elif(looking_direction < 0):
		$Sprite2D.flip_h=true
	
	if direction==0:
		$Sprite2D/AnimationPlayer.play("idle")
	else:
		if(sign(looking_direction)==sign(direction)):
			$Sprite2D/AnimationPlayer.play("walking")
		else:
			$Sprite2D/AnimationPlayer.play_backwards("walking")
	
	
	if(position.y > 500):
		on_hurt()
	
	move_and_slide()
	

func on_hurt():
	Global.lives_left -= 1
	if(Global.lives_left<=0):
		on_death()
	else:
		position = Global.spawn_pos
		emit_signal("hurt")
		$AudioStreamPlayer.stream = load("res://Player/Sounds/hurt.wav")
		$AudioStreamPlayer.volume_db = 1
		$AudioStreamPlayer.play()
		set_physics_process(false)
		$Sprite2D.flip_h=false
		$Sprite2D/AnimationPlayer.play("hurt")
	
func on_death():
	queue_free()
	emit_signal("death")

func _on_area_2d_area_entered(area: Area2D) -> void:
	match(area.get_groups()[0]):
		"Door":
			area.queue_free()
			emit_signal("pass_through_door")
			$AudioStreamPlayer.stream = load("res://Player/Sounds/walk.wav")
			$AudioStreamPlayer.volume_db = 12
			$AudioStreamPlayer.play()
			
			set_physics_process(false)
			await get_tree().create_timer(0.1).timeout
			set_physics_process(true)
		
		"Enemy":
			on_hurt()
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if(anim_name=="hurt"):
		set_physics_process(true)
