extends Resource
class_name Character

## Sprite sheet of the character containing animations.
@export var sprite_sheet : Texture2D
@export var hp_sprite : Texture2D
## How fast the character moves.
@export var movement_speed := 200.0
## How high the character can jump.
@export var jump_strength := 400
## Howmany lives the character starts with.
@export var lives := 3
