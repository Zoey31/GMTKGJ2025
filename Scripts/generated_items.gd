extends Resource
class_name GeneratedItems

static func items():
	return [
	]

static func _get_random(items):
	var randomGenerator: RandomNumberGenerator = RandomNumberGenerator.new()
	
	return items[randomGenerator.randi_range(0, len(items) - 1)]
