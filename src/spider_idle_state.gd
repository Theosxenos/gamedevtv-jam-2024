extends BaseState

@export var spider: SpiderEnemy

func enter_state() -> void:
	spider.velocity = Vector2.ZERO
