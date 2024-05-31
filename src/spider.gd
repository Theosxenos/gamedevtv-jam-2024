class_name SpiderEnemy extends Enemy

@export var jump_speed := 60
@export var retreat_distance := 150

var pounce_target: Vector2

@onready var recover_timer: Timer = $RecoverTimer

func tween_sprite() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(character_sprite, "scale", Vector2(1.5, 1.5), 1.25)

#func handle_start_pounce_state() -> void:
#	_
#	state = SpiderState.POUNCING
#
#	var direction: Vector2 = global_position.direction_to(_pounce_target)
#	velocity = direction * jump_speed
#

#
#func handle_pouncing_state() -> void:
#	var pounce_target_distance := global_position.distance_to(_pounce_target)
#	if pounce_target_distance < 50:
#		state = SpiderState.END_POUNCE
#
#	move_and_slide()
#
#func handle_end_pounce_state() -> void:
#	var pounce_target_distance := global_position.distance_to(_pounce_target)
#
#	var tween: Tween = create_tween()
#	tween.tween_property(character_sprite, "scale", Vector2(1, 1), 1.25)
#
#	if pounce_target_distance <= 1:
#		state = SpiderState.IDLE
#		recover_timer.start()
#
#func handle_retreat_state() -> void:
#	var direction: Vector2 = global_position.direction_to(_player.global_position).normalized()
#	velocity = -direction * jump_speed
#
#	if global_position.distance_to(_player.global_position) >= retreat_distance:
#		velocity = Vector2.ZERO
#		state = SpiderState.MOVE
#
#func handle_idle_state() -> void:
#	velocity = Vector2.ZERO
#
#func _on_recover_timer_timeout() -> void:
#	state = SpiderState.RETREAT
