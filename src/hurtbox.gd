class_name Hurtbox extends Area2D

signal hit(attack: Attack)

@export var invincibility_duration := 0.0

var invincible := false : set = set_invincible

@onready var invincibility_timer: Timer = $InvincibilityTimer

func take_hit(attack: Attack) -> void:
	hit.emit(attack)
	
	if invincibility_duration > 0:
		invincible = true
		invincibility_timer.start(invincibility_duration)


func _on_invincibility_timer_timeout() -> void:
		invincible = false


func set_invincible(value: bool) -> void:
	set_deferred("monitorable", !value)	
