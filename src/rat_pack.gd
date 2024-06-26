extends Node2D

signal killed

@export var rat_scene: PackedScene
@export var rat_amount := 10
@export var start_radius := 60

func _ready() -> void:
	var player := get_tree().get_first_node_in_group("player") as Player
	spawn_rats(player.global_position)
	
	
func spawn_rats(center_pos: Vector2) -> void:
	var angle_step := TAU / rat_amount
	for i in rat_amount:
		var angle := i * angle_step
		var rat: Enemy = rat_scene.instantiate()
		var direction := Vector2(cos(angle), sin(angle))
		
		rat.global_position = center_pos + direction * start_radius
		rat.killed.connect(_on_rat_killed)
		
		add_child(rat)

func _on_rat_killed() -> void:
	killed.emit()
	rat_amount -= 1
	if rat_amount <= 0:
		queue_free()
