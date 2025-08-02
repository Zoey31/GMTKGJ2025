extends Panel

@export var player: PlayerController
@export var life_orbs: Array[Control] = []

func _ready():
	if player:
		player.hit_and_die.connect(remove_life)
		player.hit.connect(remove_life)
		
func remove_life():
	if life_orbs:
		life_orbs[-1].modulate.a = 0
		life_orbs.pop_back()
