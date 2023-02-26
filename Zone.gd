extends Spatial

export var speed = 6

var reset_pos = Vector3(-50, 0, 0)

func _physics_process(delta):
	transform.origin.x += speed * delta

func _on_Area_body_entered(body):
	if body.get_name() == "Player":
		body.transform.origin = Vector3.ZERO
		transform.origin = reset_pos
