class_name Weapon extends Node2D

@export var attack_rate := 0.0

@onready var attack_timer: Timer = $AttackTimer
@onready var hitbox: Hitbox = $Hitbox

func _on_hitbox_attacked() -> void:
	hitbox.set_deferred("monitoring", false)
	attack_timer.start(attack_rate)


func _on_attack_timer_timeout() -> void:
	hitbox.set_deferred("monitoring", true)
