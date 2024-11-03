class_name Nest
extends MeshInstance3D
const MAX = 10
var health
# Called when the node enters the scene tree for the first time.
func _ready():
	health=MAX

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(health<=0):
		print("You lose!")
