extends BaseState

@export var spider: SpiderEnemy
@export var feet: CollisionShape2D

var retreat_direction: Vector2

func enter_state() -> void:
	retreat_direction = get_random_direction()
	feet.set_deferred("disabled", true)
	
	
func physics_process_state(_delta: float) -> void:
	spider.velocity = retreat_direction * spider.speed
	spider.move_and_slide()

	var distance := spider.global_position.distance_to(spider._player.global_position)
	
	if distance >= 102:
		state_machine.switch_state(state_machine.states.Move)

func get_random_direction() -> Vector2:
	# Generate a random angle in radians
	var random_angle := randf() * TAU  # TAU is 2 * PI
	# Convert the angle to a direction vector
	var direction := Vector2(cos(random_angle), sin(random_angle))
	return direction


func exit_state() -> void:
	feet.set_deferred("disabled", false)
