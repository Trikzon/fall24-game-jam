extends ColorRect

@onready var start_screen_scene: PackedScene = load("res://scenes/start_screen/start_screen.tscn")


func _ready():
	visible = true
	toggle_visibility()


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		toggle_visibility()


func toggle_visibility():
	if visible:
		visible = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		get_tree().paused = false
	else:
		visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true


func _on_resume_button_pressed():
	toggle_visibility()


func _on_to_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_packed(start_screen_scene)
