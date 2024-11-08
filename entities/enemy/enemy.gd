class_name Enemy
extends CharacterBody3D

signal died

const SPEED = 5.0

@export var nav_agent: NavigationAgent3D
@export var max_health: int = 3
@export var target_nest: Nest
@onready var attack_cooldown: Timer = $AttackCooldown
@onready var animation_player: AnimationPlayer = $SharkBlendModel/AnimationPlayer

var health = max_health
var is_dead = false

var counter = 0

func _ready():
	nav_agent.target_position = target_nest.global_position


func _physics_process(delta):
	counter += 1
	if counter % 20 != 0:
		move_and_slide()
		return
	
	if target_nest.global_position.distance_to(position)<3:
		attack()
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
	
func attack():
	#animation_player.stop()
	velocity=Vector3.ZERO
	if(attack_cooldown.is_stopped()):
		target_nest.take_damage()
		$SharkAttackNoise.play()
		attack_cooldown.start()
	return

func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	if is_dead or (target_nest.global_position.distance_to(position)<3):
		return
	velocity = safe_velocity
	rotation.y = lerp_angle(rotation.y, atan2(velocity.x, velocity.z), 10 * 0.016)
	animation_player.play("Swim")
	
	move_and_slide()


func take_damage():
	health -= 1
	if health <= 0 and not is_dead:
		is_dead = true
		$SharkDeathNoise.play()
		animation_player.play("Die")
		await animation_player.animation_finished
		await get_tree().create_timer(0.5).timeout
		queue_free()
		died.emit()
