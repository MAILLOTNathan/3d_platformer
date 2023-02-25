extends Spatial

onready var anim = $Anims

var coins = Stats
var current_anim = "New Anim"

func _physics_process(delta):
	anim.play(current_anim)

func _on_Area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.get_name() == "Player":
		current_anim = "on_player"
		coins.coins += 1
		queue_free()
