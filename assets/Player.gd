extends KinematicBody

onready var cam = $Camera
onready var HeadAnim = $Head/HeadAnim
onready var LeftShoulderAnim = $LeftShoulder/LeftArmAnim
onready var RightShoulderAnim = $RightShoulder/RightArmAnim
onready var LeftFootAnim = $LeftLeg/LeftFootAnim
onready var RightFootAnim = $RightLeg/RightFootAnim
onready var Anim = $AnimationPlayer
onready var Head = $Head

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

var current_animation = ""
var count_jump = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if current_animation != "":
		Anim.play(current_animation)
	cam.rotation_degrees.x = look_rot.x
	if between(velocity.x, -0.05, 0.05) and between(velocity.y, -0.05, 0.05) and between(velocity.z, -0.05, 0.05):
		Head.rotation_degrees.y = look_rot.y
	else:
		Head.rotation_degrees.y = 0
		rotation_degrees.y = look_rot.y
	
	if (Input.is_action_just_pressed("Jump")):
		current_animation = "Jump"
		if count_jump < MAX_JUMP:
			count_jump += 1
			velocity.y = jump_force
	if current_animation == "Fall" and is_on_floor():
		current_animation = "Walking"
	if is_on_floor():
		count_jump = 0
	if not is_on_floor():
		if -0.05 >= velocity.y: 
			current_animation = "Fall"
		velocity.y -= gravity * delta


	if Input.is_action_pressed("Forward") or Input.is_action_pressed("Backward") or Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
		if is_on_floor():
			current_animation = "Walking"
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

func _end_animation():
	current_animation = "Walking"

func between(n: float, a: float, b: float):
	return a <= n and n <= b














# si perso en dessous de y = -20: faire respawn le joueur
