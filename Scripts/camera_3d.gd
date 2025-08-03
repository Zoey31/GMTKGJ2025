extends Camera3D

@export_category("Moving variables")
@export var camera_distance_per_rotate: float = 0.5
@export var cylinder: AutoRotationWorldCylinder = null
@export var speed = 0.25

var newPosition: float

func _ready() -> void:
	newPosition = 1
	if cylinder:
		cylinder.rotation_done.connect(move_camera_on_rotate)

func _process(delta):
	#position.y = clampf(position.y + delta * speed, position.y, newPosition)
	var arm: SpringArm3D = $".."
	arm.spring_length = clampf(arm.spring_length + delta * speed, arm.spring_length, newPosition)

func move_camera_on_rotate():
	newPosition += camera_distance_per_rotate
