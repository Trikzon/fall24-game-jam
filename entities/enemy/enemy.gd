extends CharacterBody3D


const SPEED = 5.0

@export var nav_agent: NavigationAgent3D

@onready var animation_player: AnimationPlayer = $SharkBlendModel/AnimationPlayer


func _ready():
	nav_agent.target_position = Vector3.ZERO

func _physics_process(delta):
	if NavigationServer3D.map_get_iteration_id(nav_agent.get_navigation_map()) == 0:
		return
	if nav_agent.is_navigation_finished():
		return
	
	var next_path_position: Vector3 = nav_agent.get_next_path_position()
	var new_velocity: Vector3 = global_position.direction_to(next_path_position) * SPEED
	if nav_agent.avoidance_enabled:
		nav_agent.set_velocity(new_velocity)
	else:
		_on_navigation_agent_3d_velocity_computed(new_velocity)


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	
	rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z), 10 * 0.016)
	animation_player.play("ArmatureAction")
	
	move_and_slide()
