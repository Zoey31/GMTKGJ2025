extends Node3D

func _ready():
	$Area3D.connect("area_entered", despawn)
	
func despawn(area: Area3D):
	var item = area.get_parent()
	if item.is_in_group("pickup"):
		item.get_parent().remove_child(item)
