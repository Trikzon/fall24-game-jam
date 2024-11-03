extends Node3D

@onready var main_scene: PackedScene = load("res://scenes/main/main.tscn")
@onready var orca_anim_player: AnimationPlayer = $OrkaBlendModel/AnimationPlayer


func _process(delta):
	orca_anim_player.play("Idle")


func _on_button_pressed():
	get_tree().change_scene_to_packed(main_scene)
