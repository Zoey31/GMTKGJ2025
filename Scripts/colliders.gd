extends GeneratedItems
class_name Colliders

static func items():
	return [
		preload("res://GameObjects/Colliders/barrier.tscn"),
		preload("res://GameObjects/Colliders/trash_can.tscn"),
		preload("res://GameObjects/Colliders/car.tscn"),
	]


static func get_random():
	return _get_random(items())
