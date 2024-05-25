extends Area2D

@export var projectile_scene: PackedScene

@onready var projectile_start: Marker2D = $ProjectileStart

var _enemy_position: Vector2

func _physics_process(delta: float) -> void:
	var enemies: Array[Node2D] = get_overlapping_bodies()
	_enemy_position = enemies[0].global_position if enemies.size() > 0 else Vector2.ZERO


func _on_fire_rate_timeout() -> void:
	fire_projectile()
	
	
func fire_projectile() -> void:
	var projectile: Orb = projectile_scene.instantiate()
	projectile.global_position = projectile_start.global_position
	
	if _enemy_position != Vector2.ZERO:
		projectile.target = _enemy_position
		add_child(projectile)
