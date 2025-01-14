extends CanvasLayer

@onready var character = Global.characters.values()[Global.selected_character]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_hud()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_hud()
	
func update_hud():
	if(Global.room>0):
		get_node("Control/VBoxContainer/Room").text=str(Global.room)
	else:
		get_node("Control/VBoxContainer/Room").text="-"
	$Control/Lives.text=str(Global.lives_left)
	$Control/Lives2.texture=character.hp_sprite
