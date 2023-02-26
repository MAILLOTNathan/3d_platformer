extends Spatial

onready var error = $Error

export var path = ""

var stat = Stats

func _on_Area_body_entered(body):
	if body.get_name() == "Player":
		if stat.coins == 3:
			get_tree().change_scene(path)
		else:
			error.visible = true
			yield(get_tree().create_timer(3.0), "timeout")
			error.visible = false
