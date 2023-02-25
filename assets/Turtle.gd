extends KinematicBody

onready var mem = $Members

export var speed = 5
export var max_distance = 100
export var min_distance = -100

var stat = Stats
var cur_distance = 0
var timer = 0
var velocity = Vector3.ZERO
var is_alive = true

func _physics_process(delta):
	if not is_alive:
		if timer < 5:
			timer += delta
		else:
			is_alive = true
			mem.visible = true
			timer = 0
	if cur_distance < max_distance and cur_distance > min_distance and is_alive:
		translation.z += speed * delta
		cur_distance += speed * delta
	else:
		if is_alive:
			cur_distance = 0
			rotation_degrees.y += 180
			speed = -speed


func _on_HurtBox_body_entered(body):
	if body.get_name() == "Player":
		mem.visible = false
		body.velocity = Vector3(body.velocity.x, body.velocity.y + 50, body.velocity.z)
		is_alive = false


func _on_Hitbox_body_entered(body):
	if body.get_name() == "Player":
		stat.health -= 1
