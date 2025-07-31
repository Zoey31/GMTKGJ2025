extends GeneratedItems
class_name Colliders

static func items():
	return [
		preload("res://GameObjects/Colliders/box.tscn"),
		preload("res://GameObjects/Colliders/trash_can.tscn"),
	]


static func get_random():
	return _get_random(items())
