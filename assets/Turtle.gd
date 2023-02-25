extends KinematicBody

onready var trigger = $Trigger

export var speed = 5
export var max_distance = 100
export var min_distance = -100

var cur_distance = 0
var velocity = Vector3.ZERO

func _physics_process(delta):
	if cur_distance < max_distance and cur_distance > min_distance:
		translation.z += speed * delta
		cur_distance += speed * delta
	else:
		cur_distance = 0
		rotation_degrees.y += 180
		speed = -speed
