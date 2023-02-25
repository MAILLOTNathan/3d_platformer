extends Spatial

onready var anim = $Anims

var coins = Stats

func _physics_process(delta):
	anim.play("rotate")

func _on_Area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.get_name() == "Player":
		coins.coins += 1
		queue_free()
