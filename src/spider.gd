class_name Spider extends Enemy


@export var jump_speed := 60

var _pounce_target: Vector2
	
func _physics_process(delta: float) -> void:
	if state == EnemyState.POUNCE:
		state = EnemyState.POUNCING
		_pounce()
		
	elif state == EnemyState.POUNCING:
		var direction: Vector2 = global_position.direction_to(_pounce_target)
		velocity = direction * jump_speed
		move_and_slide()
		
		var distance := global_position.distance_to(_pounce_target)
		if distance < 50:
			var _tween: Tween = create_tween()
			_tween.tween_property(character_sprite, "scale", Vector2(1, 1), 1.25)
		if distance <= 1:
			state = EnemyState.IDLE
			$RecoverTimer.start()
		
	elif state == EnemyState.IDLE:
		velocity = Vector2.ZERO
	
	else:
		super._physics_process(delta)

	
func _pounce() -> void:
	_pounce_target = _player.global_position
	
	if global_position.distance_to(_pounce_target) < 5:
		state = EnemyState.MOVE
		return
	
	$Area2D.set_deferred("monitoring", false)
	
	var _tween: Tween = create_tween()
	_tween.tween_property(character_sprite, "scale", Vector2(1.5, 1.5), 1.25)
	state = EnemyState.POUNCING


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		state = EnemyState.POUNCE


func _on_recover_timer_timeout() -> void:
	$Area2D.set_deferred("monitoring", true)	
