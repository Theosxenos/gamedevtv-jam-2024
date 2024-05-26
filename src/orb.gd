class_name Orb extends Area2D

@export var max_range := 100.0
@export var speed := 50.0
@export var attack: Attack

var direction: Vector2

var _travelled_distance: float

func _ready() -> void:
	rotation = direction.angle()


func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	
	_travelled_distance += speed * delta
	if _travelled_distance >= max_range:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is Hurtbox:
		(area as Hurtbox).take_hit(attack)
		
	queue_free()
