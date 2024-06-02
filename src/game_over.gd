class_name GameOver extends Control

@onready var enemies_dead_label: Label = $GridContainer/EnemiesDeadLabel
@onready var time_survived_amount_label: Label = $GridContainer/TimeSurvivedAmountLabel

func set_killcount(value: int) -> void:
	enemies_dead_label.text = str(value)

func set_time_survived(value: float) -> void:
	var seconds: int = floor(fmod(value, 1000))
	var minutes: int = floor(fmod((value / 1000), 60))
	
	time_survived_amount_label.text = "%s:%s" % [minutes, seconds]
