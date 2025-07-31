extends GeneratedItems
class_name Pickups



static func items():
	return [
		preload("res://GameObjects/Pickups/coin.tscn"),
		preload("res://GameObjects/Pickups/diamond.tscn"),
	]

static func get_random():
	return _get_random(items())
