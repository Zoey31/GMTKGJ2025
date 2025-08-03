extends CharacterBody3D
class_name PlayerController

@export var left_restriction: float = -5.0
@export var right_restriction: float = 5.0
@export var camera: Camera3D
@export var world: AutoRotationWorldCylinder

@export var speed: float = 30
@export var acceleration: float = 2
@export var extra_points_per: float = 36
@export var extra_point: float = 10

var life = 3
var vel: Vector3 = Vector3(0, 0, 0)
var distance_counter = 0
var is_dead = false


signal pickup_item(pickup: PickupStats)
signal hit_and_die()
signal score_screen()
signal hit()

func add_score_per_distance(_cur):
	
	if _cur >= distance_counter + extra_points_per:
		distance_counter = _cur
		var pickup = PickupStats.new()
		pickup.points = extra_point
		pickup_item.emit(pickup)
		
func add_score_per_finish():
	distance_counter = 0
	var pickup = PickupStats.new()
	pickup.points = extra_point
	pickup_item.emit(pickup)

func _ready():
	$Area3D.connect("area_entered", handle_collision)
	if world:
		world.rotation_handle.connect(add_score_per_distance)
		world.rotation_done.connect(add_score_per_finish)

func display_score_screen(_ignore):
	score_screen.emit()

func handle_collision(area: Area3D):
	var hit_element = area.get_parent()
	if hit_element.is_in_group("pickup"):
		if hit_element is PickupStats:
			pickup_item.emit(hit_element)
		hit_element.get_parent().remove_child(hit_element)
		
	if hit_element.is_in_group("collider"):
		life -= 1
		if life < 1:
			$AnimationPlayer.play("die")
			hit_and_die.emit()
			$AnimationPlayer.animation_finished.connect(
				display_score_screen
			)
			is_dead = true
		else:
			$AnimationPlayer.play("hit")
			hit.emit()

func _process(delta):
	if is_dead:
		velocity = Vector3(0, 0, 0)
		return
	if Input.is_action_pressed("left"):
		vel.z = max(vel.z - acceleration, -speed)
	elif Input.is_action_pressed("right"):
		vel.z = min(vel.z + acceleration, speed)
	else:
		vel.z = lerp(vel.z, 0.0, 0.2) 
	
	velocity = vel
	
	if position.z < left_restriction:
		position.z = left_restriction
		velocity = Vector3(0, 0, 0)
	if position.z > right_restriction:
		position.z = right_restriction
		velocity = Vector3(0, 0, 0)
	
func _physics_process(_delta):
	move_and_slide()
