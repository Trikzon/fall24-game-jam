extends Control

@export var spawner_manager: Node3D

func _process(delta):
	$Label.text = "Wave %s/%s" % [str(spawner_manager.current_wave), str(spawner_manager.waves.size())]
