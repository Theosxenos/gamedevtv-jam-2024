class_name Hud extends Control

@export var score_label: Label
#@export var time_label: Label

var kill_count := 0 : set = _set_kill_count

var _elapsed_seconds := 0

func _ready() -> void:
	#update_label()
	pass


#func _on_game_timer_timeout() -> void:
	#_elapsed_seconds += 1
	#update_label()
	
#func update_label() -> void:
	#var seconds := _elapsed_seconds % 60
	#var minutes := (_elapsed_seconds / 60) % 60
	#
	#time_label.text = "%d:%d" % [minutes, seconds]


func _set_kill_count(value: int) -> void:
	kill_count = value
	score_label.text = str(kill_count)
