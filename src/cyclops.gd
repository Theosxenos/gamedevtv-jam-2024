extends CharacterBody2D


@export var speed := 40.0

var _player : Player

func _ready() -> void:
	_player = get_tree().get_first_node_in_group("player")
	
	
func _physics_process(delta: float) -> void:
	var direction := global_position.direction_to(_player.global_position)
	velocity = direction * speed
	move_and_slide()
