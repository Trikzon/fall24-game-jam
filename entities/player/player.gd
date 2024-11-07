extends CharacterBody3D

const ACCELERATION = 5.0
const MAX_SPEED = 5.0
const RISE_SPEED = 5.0

@export var camera_target: Node3D
@export var ground_raycast_back: RayCast3D
@export var ground_raycast_front: RayCast3D

@onready var puffer: PackedScene = load("res://entities/puffer.tscn")
@onready var blast_scene: PackedScene = load("res://entities/Attacks/blast.tscn")
@onready var blast_cooldown_timer: Timer = $BlastCooldownTimer
@onready var dash_timer: Timer = $DashTimer
@onready var dash_cooldown_timer: Timer = $DashCooldownTimer
@onready var puffer_cooldown_timer: Timer = $PufferCooldown
@onready var incrementalDash = 1
@onready var directionPuff = Vector3.ZERO
func _process(delta):
	#attack
	if Input.is_action_just_pressed("Attack") and blast_cooldown_timer.is_stopped():
		blast_cooldown_timer.start()
		var blast: Blast = blast_scene.instantiate()
		add_sibling(blast)
		blast.position = position
		blast.transform.basis.z += 3.75 * Vector3(1,1,1)
		blast.rotation = rotation
		if (randi_range(0,1) == 0):
			$AttackNoise.play()
		else:
			$Idle1.play()
		
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


func _physics_process(delta):
	
	if Input.is_action_pressed("player_forward"):
		velocity -= camera_target.transform.basis.z * ACCELERATION * delta
		directionPuff=camera_target.transform.basis.z
		rotation.y = lerp_angle(rotation.y, camera_target.rotation.y, 10 * delta)
		rotation.x = lerp_angle(rotation.x, camera_target.rotation.x, 10 * delta)
		if not $OrkaBlendModel.get_child(1).is_playing():
			$OrkaBlendModel.get_child(1).play("Swim")
	else:
		if not $OrkaBlendModel.get_child(1).is_playing():
			$OrkaBlendModel.get_child(1).play("Idle")
		velocity = lerp(velocity, Vector3.ZERO, 2 * delta)
		
	#if not ground_raycast_front.is_colliding() and not ground_raycast_front.is_colliding():
		#velocity += get_gravity() * delta
		#puffer
	if Input.is_action_just_pressed("puffer")and puffer_cooldown_timer.is_stopped():
		puffer_cooldown_timer.start()
		puffer.instantiate()
		var pufferfish = puffer.instantiate()
		add_sibling(pufferfish)
		pufferfish.global_position.x = global_position.x
		pufferfish.global_position.y = global_position.y + 2
		pufferfish.global_position.z = global_position.z
		pufferfish.player = self
		pufferfish.playerV=-directionPuff * MAX_SPEED
	
	velocity = velocity.clamp(Vector3.ONE * -MAX_SPEED, Vector3.ONE * MAX_SPEED)
	if(Input.is_action_pressed("Rise")):
		velocity.y += RISE_SPEED * delta
	if(Input.is_action_pressed("Dash") and dash_timer.is_stopped() and dash_cooldown_timer.is_stopped()):
		$DashSFX.play()
		dash_timer.start()
		dash_cooldown_timer.start()
		incrementalDash=0
	if(not dash_timer.is_stopped()):	
		velocity = -camera_target.transform.basis.z * ACCELERATION * delta * 200
		incrementalDash+=1
		if(incrementalDash%16==0):
			var blast: Blast = blast_scene.instantiate()
			add_sibling(blast)
			blast.position = position
			blast.transform.basis.z += 3.75 * Vector3(1,1,1)
			blast.rotation = rotation
	move_and_slide()
