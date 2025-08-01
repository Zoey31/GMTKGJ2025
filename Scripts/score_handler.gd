extends PanelContainer

@export_category("Required")
@export var player: PlayerController
var score = 0

func _ready():
	$RichTextLabel.text = str(score)
	if player:
		player.pickup_item.connect(add_to_score)
	
func add_to_score(pickup: PickupStats):
	score += pickup.points
	$RichTextLabel.text = str(score)
