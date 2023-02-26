extends Spatial

onready var player = $Player
onready var zone = $Zone

var base = Vector3.ZERO

func _physics_process(delta):
	if player.transform.origin == base:
		zone.transform.origin.x = zone.reset_pos.x
