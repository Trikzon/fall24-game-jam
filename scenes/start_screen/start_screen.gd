extends Node3D

@onready var begin_scene: PackedScene = load("res://scenes/Begining Explantion/intro_scene.tscn")
@onready var orca_anim_player: AnimationPlayer = $OrkaBlendModel/AnimationPlayer


func _process(delta):
	orca_anim_player.play("Idle")


func _on_button_pressed():
	get_tree().change_scene_to_packed(begin_scene)
