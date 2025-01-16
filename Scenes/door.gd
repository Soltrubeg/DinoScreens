extends StaticBody2D

@export var yAxis : float

func _ready() -> void:
	print("???")
	Global.room_y += yAxis
	Global.camera_y = yAxis
	print(Global.room_y)
