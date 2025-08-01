extends RichTextLabel

func _ready():
	$AnimationPlayer.animation_finished.connect(remove)
	
func start(value):
	text = "+" + str(value)
	$AnimationPlayer.play("flow")
	
func remove(_ignore):
	get_parent().remove_child(self)
