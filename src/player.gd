class_name Player extends CharacterBody2D

signal died

@export_category("Player Stats")
@export var health := 100.0
@export var max_health := 100.0
@export var speed := 45.0

@export_category("Controls")
@export var health_bar: ProgressBar

var direction := Vector2.ZERO

func _ready() -> void:
	health_bar.value = health / max_health

func _physics_process(_delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up" ,"move_down")
	velocity = direction * speed
	move_and_slide()


func _on_hurtbox_hit(attack: Attack) -> void:
	health -= attack.damage
	if health <= 0:
		die()
	
	health_bar.value = health / max_health

	
func die() -> void:
	died.emit()
