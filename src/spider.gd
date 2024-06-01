class_name SpiderEnemy extends Enemy

@export var jump_speed := 60
@export var retreat_distance := 150

var pounce_target: Vector2

@onready var state_machine: StateMachine = $StateMachine

func _on_hurtbox_hit(attack: Attack) -> void:
	health -= attack.damage
	
	if attack.knockback_force > 0:
		var knockback_direction := global_position.direction_to(_player.global_position) * -1
		velocity = knockback_direction * attack.knockback_force
		
		state_machine.switch_state(state_machine.states.Knockback)
