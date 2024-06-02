extends Node

var kill_count := 0
var elapsed_time := 0.0
var game_running := false

@onready var hud: Hud = %HUD

func _ready() -> void:
	%MainMenu.show()
	%GameOver.hide()

func _process(delta: float) -> void:
	if game_running:
		elapsed_time += delta


func on_enemy_died() -> void:
	kill_count += 1
	hud.kill_count = kill_count


func _on_enemy_spawner_enemy_spawned(enemy) -> void:
	enemy.killed.connect(on_enemy_died)


func _on_player_died() -> void:
	%Dialog.show()
	
	%GameOver.show()
	%GameOver.set_killcount(kill_count)
	%GameOver.set_time_survived(elapsed_time)
	
	$Level.set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)
	#get_tree().call_group("enemy", "queue_free")

func _on_play_button_pressed() -> void:
	%MainMenu.queue_free()
	%Dialog.hide()
	$Level.process_mode = Node.PROCESS_MODE_INHERIT
	game_running = true


func _on_restart_button_pressed():
	#var current_scene = get_tree().current_scene
	var scene_path = "res://assets/main/main.tscn"
	get_tree().change_scene_to_file(scene_path)
