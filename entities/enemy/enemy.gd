class_name Enemy
extends CharacterBody3D


const SPEED = 5.0

@export var nav_agent: NavigationAgent3D
@export var max_health: int = 3

@onready var animation_player: AnimationPlayer = $SharkBlendModel/AnimationPlayer

var health = max_health
var is_dead = false


func _ready():
	nav_agent.target_position = Vector3.ZERO


func _physics_process(delta):
	if is_dead:
		return
	
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
	if is_dead:
		return
	
	velocity = safe_velocity
	
	rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z), 10 * 0.016)
	animation_player.play("Swim")
	
	move_and_slide()


func take_damage():
	health -= 1
	if health <= 0 and not is_dead:
		is_dead = true
		animation_player.play("Die")
		await animation_player.animation_finished
		queue_free()
