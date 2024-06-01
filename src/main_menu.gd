extends Control

@export var game_scene: PackedScene

func _on_start_button_pressed() -> void:
	get_tree().root.add_child(game_scene.instantiate())
	queue_free()
