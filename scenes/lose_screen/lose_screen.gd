extends Node3D

@onready var start_screen_scene: PackedScene = load("res://scenes/start_screen/start_screen.tscn")
@onready var sharks: Node3D = $Sharks


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _process(delta: float) -> void:
	for shark in sharks.get_children():
		shark.get_child(1).play("Swim")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(start_screen_scene)
