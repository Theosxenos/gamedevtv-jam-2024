class_name Enemy extends CharacterBody2D

signal killed

enum EnemyState {MOVE, KNOCKBACK, POUNCE, POUNCING, IDLE}

@export var health := 1 : set = _set_health
@export var speed := 40.0
@export var knockback_friction := 40
@export var state: EnemyState = EnemyState.MOVE

var _player: Player

@onready var character_sprite: Sprite2D = $CharacterSprite

func _ready() -> void:
	_player = get_tree().get_first_node_in_group("player")
	
	
func _physics_process(delta: float) -> void:
	if state == EnemyState.MOVE:
		var direction := global_position.direction_to(_player.global_position)
		
		character_sprite.flip_h = true if direction.x < 0 else false
		velocity = direction * speed
		move_and_slide()
		
	if state == EnemyState.KNOCKBACK:
		velocity = velocity.move_toward(Vector2.ZERO, knockback_friction * delta)
		if velocity == Vector2.ZERO:
			state = EnemyState.MOVE
		else:		
			move_and_slide()


func _on_hurtbox_hit(attack: Attack) -> void:
	health -= attack.damage
	
	var knockback_direction := global_position.direction_to(_player.global_position) * -1
	velocity = knockback_direction * attack.knockback_force
	state = EnemyState.KNOCKBACK
	

func _set_health(value: int) -> void:
	health = value
	if health <= 0:
		queue_free()
		killed.emit()
