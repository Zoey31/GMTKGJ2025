extends Node3D
class_name AutoRotationWorldCylinder

var hurry_up_sound = preload("res://Sounds/Hurry-up_149097__setuniman__in-a-hurry-q38o2m.wav")


@export_category("Variables")
@export var speed: float = 15
@export var tick_interval: float = 5
@export_category("Required")
@export var player: PlayerController
@export_category("Information only")
@export var rotation_count: int = 0
var current_rotation_value: float = 0
var current_tick_value: float = 0
var is_rotating = true

var speed_increase = 5

signal rotation_done()
signal rotation_tick(current_rotation_value)
signal rotation_handle(current_rotation_value)

func _ready():
	if player != null:
		player.hit_and_die.connect(stop_rotation)

func stop_rotation():
	is_rotating = false
	
func start_rotation():
	is_rotating = true
	
func _physics_process(delta: float) -> void:
	if !is_rotating:
		return
		
	rotation_degrees.z += delta * speed
	current_rotation_value += delta * speed
	current_tick_value += delta * speed

	if current_tick_value > tick_interval:
		current_tick_value -= tick_interval
		rotation_tick.emit(current_rotation_value)
	
	if current_rotation_value >= 360:
		rotation_count += 1
		current_rotation_value -= 360
		speed += speed_increase
		$"../AudioStreamPlayer3D".play()
		rotation_done.emit()

	rotation_handle.emit(current_rotation_value)
