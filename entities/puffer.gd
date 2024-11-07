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
	
	for body in $Area3D2.get_overlapping_bodies():
		if body is Enemy:
			for i in range(5):
				body.take_damage()
	
	await get_tree().create_timer(2).timeout
	queue_free()

func _on_area_3d_body_entered(body):
	if((not animation_player.is_playing())and((body is Enemy) or (body is Terrain3D))):
		blowup()
