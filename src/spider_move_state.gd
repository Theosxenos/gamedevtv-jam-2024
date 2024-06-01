extends BaseState

@export var spider: SpiderEnemy

var player: Player

func _ready() -> void:
	super._ready()
	
	player = get_tree().get_first_node_in_group("player")
	
	
func physics_process_state(_delta: float) -> void:
	var distance_to_player := spider.global_position.distance_to(player.global_position)
	
	if distance_to_player >= 95 and distance_to_player <= 105:
		state_machine.switch_state(state_machine.states.StartPounce)
	elif distance_to_player < 95:
		state_machine.switch_state(state_machine.states.Retreat)
	else:
		var direction: Vector2 = spider.global_position.direction_to(player.global_position)
		spider.velocity = direction * spider.speed
		spider.move_and_slide()
