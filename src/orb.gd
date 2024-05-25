class_name Orb extends Area2D

@export var range := 100.0
@export var speed := 50.0
@export var attack: Attack

var target: Vector2

var _direction: Vector2
var _travelled_distance: float

func _ready() -> void:
	_direction = global_position.direction_to(target)
	rotation = _direction.angle()


func _physics_process(delta: float) -> void:
	position += _direction * speed * delta
	
	_travelled_distance += speed * delta
	if _travelled_distance >= range:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is Hurtbox:
		(area as Hurtbox).take_hit(attack)
		
	queue_free()
