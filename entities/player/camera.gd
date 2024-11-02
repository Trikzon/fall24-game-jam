extends Node3D

@export var camera_target: Node3D
@export var camera_parent: Node3D
@export var pitch_max = 50
@export var pitch_min = -50

var yaw = float()
var pitch = float()
var yaw_sensitivity = 0.002
var pitch_sensitivity = 0.002


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() != 0:
		yaw += -event.relative.x * yaw_sensitivity
		pitch += -event.relative.y * pitch_sensitivity


func _physics_process(delta):
	camera_target.rotation.y = lerpf(camera_target.rotation.y, yaw, delta * 10)
	camera_target.rotation.x = lerpf(camera_target.rotation.x, pitch, delta * 10)
	
	pitch = clamp(pitch, deg_to_rad(pitch_min), deg_to_rad(pitch_max))
	
	camera_smooth_follow(delta)


func camera_smooth_follow(delta):
	#var cam_offset = Vector3(0, 1.5, 0).rotated(Vector3.UP, camera_target.global_transform.basis.get_euler().y)
	global_transform.origin = camera_parent.global_transform.origin# + cam_offset