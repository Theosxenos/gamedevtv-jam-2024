class_name EnemySpawner extends Node2D


@export var spawn_positions: Array[Vector2]
@export var enemy_scene: PackedScene

var _parent: Node2D

func _ready() -> void:
	_parent = get_parent()
	
	for p in $SpawnPositions.get_children():
		spawn_positions.append(p.global_position)


func _on_spawn_timer_timeout() -> void:
	var enemy: CharacterBody2D = enemy_scene.instantiate()
	enemy.global_position = spawn_positions.pick_random()
	
	_parent.add_child(enemy)
