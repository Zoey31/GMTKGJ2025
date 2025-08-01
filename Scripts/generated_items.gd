extends Resource
class_name GeneratedItems

static func items():
	return [
	]

static func _get_random(selected_items):
	var randomGenerator: RandomNumberGenerator = RandomNumberGenerator.new()
	
	return selected_items[randomGenerator.randi_range(0, len(selected_items) - 1)]
