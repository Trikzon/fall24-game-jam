class_name Blast
extends Area3D

var timer: float = 1.5
@export var speed: float
@export var scaleSpeed: float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#position.z -= speed * delta
	position -= transform.basis.z * delta * speed
	scale += scaleSpeed * Vector3(1,1,1) * delta
	timer -= delta
	if timer <= 0:
		queue_free()





func _on_body_entered(body: Node3D) -> void:
	if body is Enemy:
		print("hit")
