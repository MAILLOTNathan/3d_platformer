extends Spatial

export var path = ""

func _on_Area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.get_name() == "Player":
		get_tree().change_scene(path)
