extends CharacterBody3D
@onready var animation_player: AnimationPlayer = $pufferfishblow/AnimationPlayer

const SPEED = 100.0
const JUMP_VELOCITY = 4.5
var player: CharacterBody3D
var playerV: Vector3
var first = true
var moving = true

func _physics_process(delta):
	if first:
		rotation.x=player.rotation.x
		rotation.y=player.rotation.y
		rotation.z=player.rotation.z
		first=false
	if(moving):
		velocity.x=playerV.x*SPEED*delta
		velocity.y=playerV.y*SPEED*delta
		velocity.z=playerV.z*SPEED*delta
		move_and_slide()
	else:
		velocity=Vector3.ZERO

func blowup():
	moving=false
	animation_player.play("ArmatureAction_001")
	await get_tree().create_timer(1.6).timeout
	queue_free()

func _on_area_3d_body_entered(body):
	if((not animation_player.is_playing())and((body is Enemy) or (body is Terrain3D))):
		blowup()
	#if body is Enemy:
		#body.take_damage()
	#elif body is Terrain3D:
		#await get_tree().create_timer(0.25).timeout
		#queue_free() # Replace with function body.

func _on_area_3d_2_body_entered(body):
	if(moving==false and body is Enemy):
		for i in range(20):
			body.take_damage()
		print(body)
		print(body.health)
