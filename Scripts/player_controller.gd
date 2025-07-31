extends Node3D

@export var left_restriction: float = -5.0
@export var right_restriction: float = 5.0
@export var camera: Camera3D

@export var speed: float = 30

signal pickup_item()
signal hit_and_die()

func _ready():
	$Area3D.connect("area_entered", handle_collision)

func handle_collision(area: Area3D):
	if area.get_parent().is_in_group("pickup"):
		area.get_parent().get_parent().remove_child(area.get_parent())
		pickup_item.emit()
	if area.get_parent().is_in_group("collider"):
		visible = false
		hit_and_die.emit()

func _process(delta):

	if Input.is_action_pressed("left"):
		position.z -= delta * speed
		if position.z < left_restriction:
			position.z = left_restriction
			
	if Input.is_action_pressed("right"):
		position.z += delta * speed
		if position.z > right_restriction:
			position.z = right_restriction
		
