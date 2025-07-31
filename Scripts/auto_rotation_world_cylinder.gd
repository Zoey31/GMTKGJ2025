extends Node3D
@export_category("Moving variables")
@export var speed: float = 0.1


func _physics_process(delta: float) -> void:
	rotation_degrees.z += delta * speed
