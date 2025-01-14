extends CanvasLayer

@onready var character = Global.characters.values()[Global.selected_character]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_hud()
	get_tree().paused=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_hud()
	
func update_hud():
	if(Global.room>0):
		get_node("Control/VBoxContainer/Room").text=str(Global.room)
	else:
		get_node("Control/VBoxContainer/Room").text="-"
	if(Global.lives_left>0): $Control/Lives.text=str(Global.lives_left)
	else: $Control/Lives.text="X"
	$Control/Lives2.texture=character.hp_sprite
	$Control/Time.text=get_time()
	
func get_time():
	if(Global.start_time==-1):
		return "0:00.00"
	var current_time = Time.get_ticks_msec() - Global.start_time
	var minutes = current_time/1000/60
	var seconds = current_time/1000%60
	var msec = current_time%1000/10
	return str(minutes)+":"+str(seconds).pad_zeros(2)+"."+str(msec).pad_zeros(2)
