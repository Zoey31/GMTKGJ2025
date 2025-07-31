extends Camera3D

@export_category("Moving variables")
@export var camera_distance_per_rotate: float = 0.5
@export var cylinder: AutoRotationWorldCylinder = null

func _ready() -> void:
	if cylinder:
		cylinder.rotation_done.connect(move_camera_on_rotate)
	
func move_camera_on_rotate():
	position.y += camera_distance_per_rotate
