class_name Hurtbox extends Area2D

signal hit(attack: Attack)

func take_hit(attack: Attack) -> void:
	hit.emit(attack)
