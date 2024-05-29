class_name Weapon extends Node2D

@export var attack_rate := 0.0

var can_attack := true : set = _set_can_attack

@onready var attack_timer: Timer = $AttackTimer
@onready var hitbox: Hitbox = $Hitbox

func _on_hitbox_attacked() -> void:
	can_attack = false
	attack_timer.start(attack_rate)


func _on_attack_timer_timeout() -> void:
	can_attack = true

	
func _set_can_attack(value : bool) -> void:
	can_attack = value
	hitbox.set_deferred("monitoring", value)
