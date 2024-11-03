extends Node3D
@onready var main_scene: PackedScene = load("res://scenes/main/main.tscn")
@onready var shark_anim_player: AnimationPlayer = $Shark/AnimationPlayer
@onready var shark2_anim_player: AnimationPlayer = $Shark2/AnimationPlayer
@onready var shark3_anim_player: AnimationPlayer = $Shark3/AnimationPlayer


func _process(delta):
	shark_anim_player.play("Swim")
	shark2_anim_player.play("Swim")
	shark3_anim_player.play("Swim")


func _on_button_pressed():
	get_tree().change_scene_to_packed(main_scene)
