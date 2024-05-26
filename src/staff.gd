extends Area2D

enum {NORMAL, ULTIMATE}

@export var projectile_scene: PackedScene
@export var ultimate_bullet_count := 36
@export var emission_radius := 0.0

@onready var fire_rate: Timer = $FireRate
@onready var projectile_start: Marker2D = $ProjectileStart

var _enemy_position: Vector2
var _state := NORMAL

func _process(_delta: float) -> void:
	if _state == NORMAL and fire_rate.is_stopped():
		fire_rate.start()

	if _state == ULTIMATE:
		emit_bullets()
		_state = NORMAL


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot"):
		_state = ULTIMATE
		fire_rate.stop()
	

func _physics_process(_delta: float) -> void:
	var enemies: Array[Node2D] = get_overlapping_bodies()
	_enemy_position = enemies[0].global_position if enemies.size() > 0 else Vector2.ZERO
	

func _on_fire_rate_timeout() -> void:
	fire_projectile()
	
	
func fire_projectile() -> void:
	var projectile: Orb = projectile_scene.instantiate()
	projectile.global_position = projectile_start.global_position
	
	if _enemy_position != Vector2.ZERO:
		projectile.direction = projectile_start.global_position.direction_to(_enemy_position)
		add_child(projectile)


func emit_bullets():
	var angle_step: float = TAU / ultimate_bullet_count
	for i in range(ultimate_bullet_count):
		var angle = i * angle_step
		var projectile: Orb = projectile_scene.instantiate()
		var direction := Vector2(cos(angle), sin(angle))
		projectile.global_position = projectile_start.global_position + direction * emission_radius
		projectile.direction = direction

		add_child(projectile)
