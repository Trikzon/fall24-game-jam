extends Node3D

@onready var main_scene: PackedScene = load("res://scenes/main/main.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_packed(main_scene)
