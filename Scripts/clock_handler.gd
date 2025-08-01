extends HBoxContainer
@export_category("Required")
@export var world: AutoRotationWorldCylinder

var arrow: TextureRect


func _ready():
	arrow = $AspectRatioContainer/Clock/TextureRect
	if world:
		world.rotation_handle.connect(update_arrow)

func update_arrow(current_tick):
	arrow.rotation_degrees = current_tick - 90
