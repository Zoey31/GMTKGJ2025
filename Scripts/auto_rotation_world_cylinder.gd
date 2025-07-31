extends Node3D
class_name AutoRotationWorldCylinder

@export_category("Variables")
@export var speed: float = 5
@export var tick_interval: float = 5
@export_category("Information only")
@export var rotation_count: int = 0
var current_rotation_value: float = 0
var current_tick_value: float = 0

signal rotation_done()
signal rotation_tick(current_rotation_value)

func _physics_process(delta: float) -> void:
	rotation_degrees.z += delta * speed
	current_rotation_value += delta * speed
	current_tick_value += delta * speed

	if current_tick_value > tick_interval:
		current_tick_value -= tick_interval
		rotation_tick.emit(current_rotation_value)
	
	if current_rotation_value >= 360:
		rotation_count += 1
		current_rotation_value -= 360
		speed += 5
		rotation_done.emit()
