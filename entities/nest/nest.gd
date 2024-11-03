class_name Nest
extends MeshInstance3D

@export var eggs: Node3D

@onready var lose_scene: PackedScene = load("res://scenes/lose_screen/lose_screen.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if eggs.get_child_count() <= 0:
		get_tree().change_scene_to_packed(lose_scene)


func take_damage():
	eggs.get_children().pick_random().queue_free()
