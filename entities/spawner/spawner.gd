class_name Spawner
extends MeshInstance3D

func _ready() -> void:
	visible = false


func spawn_enemy(enemy_scene: PackedScene, target_nest: Node3D) -> Node3D:
	var enemy = enemy_scene.instantiate()
	enemy.target_nest = target_nest
	add_sibling(enemy)
	
	enemy.global_position.x = randf_range(global_position.x - mesh.size.x / 2, global_position.x + mesh.size.x / 2)
	enemy.global_position.y = randf_range(global_position.y - mesh.size.y / 2, global_position.y + mesh.size.y / 2)
	enemy.global_position.z = randf_range(global_position.z - mesh.size.z / 2, global_position.z + mesh.size.z / 2)
	
	return enemy
