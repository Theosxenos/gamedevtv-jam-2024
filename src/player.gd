class_name Player extends CharacterBody2D

@export var speed := 45.0

var direction := Vector2.ZERO

func _physics_process(_delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up" ,"move_down")
	velocity = direction * speed
	move_and_slide()
