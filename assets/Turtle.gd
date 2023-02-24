extends KinematicBody

onready var trigger = $Trigger

export var speed = 5

var velocity = Vector3.ZERO

func _physics_process(delta):
	if trigger.is_colliding():
		print("oui")
		rotation_degrees.y = -rotation_degrees.y
	else:
		translation.z += speed * delta
