extends BaseState

@export var spider: SpiderEnemy

var v2_min := 0.8
var v2_max := 1.2

func enter_state() -> void:
	var direction_to_player := spider.global_position.direction_to(spider._player.global_position)
	var opposite_direction := direction_to_player * -1
	spider.velocity = Vector2(randf_range(opposite_direction.x * v2_min, opposite_direction.x * v2_max), randf_range(opposite_direction.y * v2_min, opposite_direction.y * v2_max))  * spider.speed

	
func physics_process_state(_delta: float) -> void:
	spider.move_and_slide()
	
	var distance := spider.global_position.distance_to(spider._player.global_position)
	
	if distance >= 110:
		state_machine.switch_state(state_machine.states.Move)
