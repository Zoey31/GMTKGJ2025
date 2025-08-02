extends Node3D

@export var positions: Array[CollisionShape3D] = []
@export var cylinder: AutoRotationWorldCylinder = null
@export_category("Generate chances")
@export var chance_for_pickup = 66
@export var chance_for_walls = 60


var randomGenerator: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	if cylinder and not positions.is_empty():
		cylinder.rotation_tick.connect(generate)

func should_generate_pickup():
	var roll = randomGenerator.randi_range(1, 100)
	
	return roll <= chance_for_pickup

func generate_pickup(current_rotation_value, selected_position):
	var pickup: PackedScene = Pickups.get_random()
	var element: Node3D = pickup.instantiate()
	cylinder.add_child(element)
	element.global_position = selected_position.global_position
	element.rotation_degrees.z -= current_rotation_value

func should_generate_colliders():
	var roll = randomGenerator.randi_range(1, 100)
	
	return roll <= chance_for_walls

func generate_colliders(current_rotation_value, selected_position):
	var pickup: PackedScene = Colliders.get_random()
	var element: Node3D = pickup.instantiate()
	cylinder.add_child(element)
	element.global_position = selected_position.global_position
	element.rotation_degrees.z -= current_rotation_value

func generate(current_rotation_value):
	var pattern = 0
	#0 - 000
	#1 - 001
	#2 - 010
	#3 - 011
	#4 - 100
	#5 - 101
	#6 - 110
	var pickup_location = {
		0: [positions[0], positions[1], positions[2]],
		1: [positions[0], positions[1]],
		2: [positions[0], positions[2]],
		3: [positions[0]],
		4: [positions[1], positions[2]],
		5: [positions[1]],
		6: [positions[2]],
	}
	var collider_location = {
		0: [],
		1: [positions[2]],
		2: [positions[1]],
		3: [positions[1], positions[2]],
		4: [positions[0]],
		5: [positions[0], positions[2]],
		6: [positions[0], positions[1]],
	}
	
	if should_generate_colliders():
		pattern = randomGenerator.randi_range(1, 6)

		for collider_position in collider_location[pattern]:
			generate_colliders(current_rotation_value, collider_position)
		
	if should_generate_pickup() and pattern in pickup_location:
		var selected_position = pickup_location[pattern][randomGenerator.randi_range(0, len(pickup_location[pattern]) - 1)]
		generate_pickup(current_rotation_value, selected_position)
	
