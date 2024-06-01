extends BaseState

@export var spider: SpiderEnemy
@export var character_sprite: Sprite2D

@onready var feet: CollisionShape2D = $"../../Feet"

func enter_state() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	
	spider.pounce_target = spider._player.global_position
	var direction := spider.global_position.direction_to(spider.pounce_target)
	spider.velocity = direction * spider.jump_speed

	var tween: Tween = get_tree().create_tween()
	tween.tween_property(character_sprite, "scale", Vector2(1.5, 1.5), 1.25)
	
	feet.set_deferred("disabled", true)


func physics_process_state(_delta: float) -> void:
	spider.move_and_slide()
	
	var distance := spider.global_position.distance_to(spider.pounce_target)
	
	if distance <= 50:
		state_machine.switch_state(state_machine.states.EndPounce)


func exit_state() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
