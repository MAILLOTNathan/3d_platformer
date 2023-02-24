extends KinematicBody

onready var cam = $Camera

export var sensibility = 0.2
export var min_angle = -80
export var max_angle = 90

export var speed = 10
export var WALK_SPEED = 15
export var RUN_SPEED = 25
export var acceleration = 50
export var deceleration = 100

export var gravity = 100
export var jump_force = 40
export var MAX_JUMP = 2
export var SPAWN = Vector3(0, 3.585, -4.04)

var velocity = Vector3.ZERO
var move_dir = Vector3.ZERO
var look_rot = Vector3.ZERO

var count_jump = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	cam.rotation_degrees.x = look_rot.x
	if velocity != Vector3.ZERO:
		rotation_degrees.y = look_rot.y
	else:
		cam.rotation_degrees.y = look_rot.y

	if (Input.is_action_just_pressed("Jump")):
		if count_jump < MAX_JUMP:
			count_jump += 1
			velocity.y = jump_force
	if is_on_floor():
		count_jump = 0
	if not is_on_floor():
		velocity.y -= gravity * delta


	if Input.is_action_pressed("Forward") or Input.is_action_pressed("Backward") or Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
		if Input.is_action_pressed("Run"):
			speed = RUN_SPEED
		else:
			speed = WALK_SPEED
	move_dir = Vector3(
		Input.get_action_strength("Right") - Input.get_action_strength("Left"),
		0,
		Input.get_action_strength("Backward") - Input.get_action_strength("Forward")
	).normalized().rotated(Vector3.UP, rotation.y)
	velocity.x = lerp(velocity.x, move_dir.x * speed, acceleration * delta)
	velocity.z = lerp(velocity.z, move_dir.z * speed, acceleration * delta)
	velocity = move_and_slide(velocity, Vector3.UP)
	if translation.y < -50:
		translation = Vector3(0, 3.585, -4.04)
		
func _input(event):
	if event is InputEventMouseMotion:
		look_rot.x -= event.relative.y * sensibility
		look_rot.x = clamp(look_rot.x, min_angle, max_angle)
		look_rot.y -= event.relative.x * sensibility
















# si perso en dessous de y = -20: faire respawn le joueur
