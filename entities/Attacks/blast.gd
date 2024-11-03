class_name Blast
extends Area3D


@export var speed: float
@export var scaleSpeed: float


var timer: float = 1.5


func _process(delta: float) -> void:
	position -= transform.basis.z * delta * speed
	scale += scaleSpeed * Vector3(1,1,1) * delta
	timer -= delta
	if timer <= 0:
		queue_free()


func _on_body_entered(body: Node3D) -> void:
	if body is Enemy:
		body.take_damage()
	elif body is Terrain3D:
		await get_tree().create_timer(0.25).timeout
		queue_free()
