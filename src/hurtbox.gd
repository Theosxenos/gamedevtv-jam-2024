class_name Hurtbox extends Area2D

signal hit

func take_hit() -> void:
	hit.emit()
