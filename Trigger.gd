extends Spatial

onready var error = $Error

export var path = ""
export(int) var coins_goal

var stat = Stats

func _on_Area_body_entered(body):
	if body.get_name() == "Player":
		if stat.coins == coins_goal:
			get_tree().change_scene(path)
		else:
			error.visible = true
			yield(get_tree().create_timer(3.0), "timeout")
			error.visible = false
