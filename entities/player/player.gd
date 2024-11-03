extends CharacterBody3D

const ACCELERATION = 5.0
const MAX_SPEED = 5.0

@export var camera_target: Node3D
@export var ground_raycast_back: RayCast3D
@export var ground_raycast_front: RayCast3D

@onready var blast_scene: PackedScene = load("res://entities/Attacks/blast.tscn")


func _physics_process(delta):
	#Add the gravity.	
	if Input.is_action_pressed("player_forward"):
		velocity -= camera_target.transform.basis.z * ACCELERATION * delta
		rotation.y = lerp_angle(rotation.y, camera_target.rotation.y, 10 * delta)
		rotation.x = lerp_angle(rotation.x, camera_target.rotation.x, 10 * delta)
		if not $OrkaBlendModel.get_child(1).is_playing():
			$OrkaBlendModel.get_child(1).play("Swim")
	else:
		if not $OrkaBlendModel.get_child(1).is_playing():
			$OrkaBlendModel.get_child(1).play("Idle")
		velocity = lerp(velocity, Vector3.ZERO, 2 * delta)
	#attack
	if Input.is_action_just_pressed("Attack"):
		var blast: Blast = blast_scene.instantiate()
		add_sibling(blast)
		blast.position = position
		blast.transform.basis.z += 3.75 * Vector3(1,1,1)
		blast.rotation = rotation
		
		await get_tree().create_timer(0.1).timeout
		
		blast = blast_scene.instantiate()
		add_sibling(blast)
		blast.position = position
		blast.transform.basis.z += 3.75 * Vector3(1,1,1)
		blast.rotation = rotation
		
		await get_tree().create_timer(0.1).timeout
		
		blast = blast_scene.instantiate()
		add_sibling(blast)
		blast.position = position
		blast.transform.basis.z += 3.75 * Vector3(1,1,1)
		blast.rotation = rotation
		
	#if not ground_raycast_front.is_colliding() and not ground_raycast_front.is_colliding():
		#velocity += get_gravity() * delta
	
	velocity = velocity.clamp(Vector3.ONE * -MAX_SPEED, Vector3.ONE * MAX_SPEED)
	
	#rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), 100 * delta)
	#rotation.x = lerp_angle(rotation.x, camera_target.rotation.x, 100 * delta)
	#rotation.y = atan2(-velocity.x, -velocity.z)
	
	move_and_slide()
