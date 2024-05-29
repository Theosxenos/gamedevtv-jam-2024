class_name Hitbox extends Area2D

signal attacked

@export var attack: Attack

func _on_area_entered(area: Area2D) -> void:
	if area is Hurtbox:
		(area as Hurtbox).take_hit(attack)
		attacked.emit()
