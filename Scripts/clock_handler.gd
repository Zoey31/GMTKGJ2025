extends HBoxContainer
@export_category("Required")
@export var world: AutoRotationWorldCylinder
var arrow: TextureRect
var animationPlayer: AnimationPlayer

func _ready():
	arrow = $AspectRatioContainer/Clock/TextureRect
	animationPlayer = $AspectRatioContainer/Clock/AnimationPlayer
	if world:
		world.rotation_handle.connect(update_arrow)
		world.rotation_done.connect(panic)

func panic():
	animationPlayer.play("panic")

func update_arrow(current_tick):
	arrow.rotation_degrees = current_tick - 90
