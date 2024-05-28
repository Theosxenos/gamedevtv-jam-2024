extends Node

var kill_count := 0

@onready var hud: Hud = %HUD

func on_enemy_died() -> void:
	kill_count += 1
	hud.kill_count = kill_count

func _on_enemy_spawner_enemy_spawned(enemy) -> void:
	enemy.killed.connect(on_enemy_died)
