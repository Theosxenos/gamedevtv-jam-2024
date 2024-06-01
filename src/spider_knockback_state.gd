extends BaseState

@export var spider: SpiderEnemy

func physics_process_state(delta: float) -> void:
	spider.velocity = spider.velocity.move_toward(Vector2.ZERO, spider.knockback_friction * delta)
	if spider.velocity == Vector2.ZERO:
		state_machine.switch_state(state_machine.states.Move)
	else:
		spider.move_and_slide()
