extends Node3D

@export var target_nest: Node3D
@export var waves: Array[Wave] = []
@export var enemy_scene: PackedScene

@onready var win_scene: PackedScene = load("res://scenes/win_screen/win_screen.tscn")

var spawners: Array[Spawner] = []
var enemies_spawned = 0
var current_wave = 0

func _ready():
	for child in get_children():
		if child is Spawner:
			spawners.append(child)


func _process(delta):	
	# Spawn next wave.
	if enemies_spawned == 0:
		if current_wave >= waves.size():
			get_tree().change_scene_to_packed(win_scene)
			return
		enemies_spawned = waves[current_wave].enemy_count
		current_wave += 1
		for i in range(enemies_spawned):
			var enemy = spawners.pick_random().spawn_enemy(enemy_scene, target_nest)
			enemy.died.connect(_on_enemy_died)
			await get_tree().create_timer(0.5).timeout


func _on_enemy_died():
	enemies_spawned -= 1
