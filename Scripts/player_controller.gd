extends CharacterBody3D
class_name PlayerController

@export var left_restriction: float = -5.0
@export var right_restriction: float = 5.0
@export var camera: Camera3D

@export var speed: float = 30

signal pickup_item(pickup: PickupStats)
signal hit_and_die()

func _ready():
	$Area3D.connect("area_entered", handle_collision)

func handle_collision(area: Area3D):
	var hit_element = area.get_parent()
	if hit_element.is_in_group("pickup"):
		if hit_element is PickupStats:
			pickup_item.emit(hit_element)
		hit_element.get_parent().remove_child(hit_element)
		
	if hit_element.is_in_group("collider"):
		visible = false
		hit_and_die.emit()

func _process(delta):
	var vel: Vector3 = Vector3(0, 0, 0)
	if Input.is_action_pressed("left"):
		vel.z -= delta * speed
		
			
	if Input.is_action_pressed("right"):
		vel.z += delta * speed
	
	velocity = vel * speed
	
	if position.z < left_restriction:
		position.z = left_restriction
		velocity = Vector3(0, 0, 0)
	if position.z > right_restriction:
		position.z = right_restriction
		velocity = Vector3(0, 0, 0)
	
func _physics_process(delta):
	move_and_slide()
