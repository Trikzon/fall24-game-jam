extends Node3D

@onready var start_screen_scene: PackedScene = load("res://scenes/start_screen/start_screen.tscn")
@onready var orca_anim_player: AnimationPlayer = $OrkaBlendModel/AnimationPlayer

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _process(delta):
	orca_anim_player.play("Idle")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(start_screen_scene)
