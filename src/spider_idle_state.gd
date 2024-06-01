extends BaseState

@export var spider: SpiderEnemy

@onready var timer: Timer = $Timer

func enter_state() -> void:
	spider.velocity = Vector2.ZERO
	timer.start()


func _on_timer_timeout() -> void:
	state_machine.switch_state(state_machine.states.Retreat)


func exit_state() -> void:
	timer.stop()
