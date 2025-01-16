extends CharacterBody2D


@export var speed : float = 60

@export_enum("Left: -1", "Right: 1") var direction = -1

func _ready() -> void:
	scale.x=direction*2

func _physics_process(delta: float) -> void:
	velocity.x = direction*speed
		
	if(!$RayCast2D.is_colliding() && is_on_floor()):
		flip()
		
	#if not is_on_floor():
		#velocity += get_gravity() * delta


	move_and_slide()
	
func flip():
	velocity.x = move_toward(velocity.x, 0, speed)
	direction = direction * -1
	scale.x = scale.x*-1
	print(direction)
	
