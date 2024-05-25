class_name Player extends CharacterBody2D

@export var speed := 45.0
@export var projectile_scene: PackedScene

var direction := Vector2.ZERO

func _physics_process(_delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up" ,"move_down")
	velocity = direction * speed
	move_and_slide()


func _on_fire_rate_timeout() -> void:
	fire_projectile()
	
	
func fire_projectile() -> void:
	var projectile: Orb = projectile_scene.instantiate()
	projectile.global_position = global_position - Vector2(15,0)
	var enemy = get_tree().get_first_node_in_group("enemy")
	if enemy:
		projectile.target = enemy.global_position
		get_parent().add_child(projectile)
