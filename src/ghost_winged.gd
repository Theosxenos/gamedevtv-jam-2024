extends Node2D

@export var enemy_scene : PackedScene
@export var number_of_enemies : int = 5
@export var spacing : float = 100.0
@export var wing_angle : float = 30.0

func _ready():
	create_winged_formation()
	
func create_winged_formation():
	if enemy_scene == null:
		print("Error: Enemy scene not assigned.")
		return

	for i in range(number_of_enemies):
		var enemy_instance = enemy_scene.instantiate()
		var angle_offset = -wing_angle / 2 + (wing_angle / (number_of_enemies - 1)) * i
		var position_offset = Vector2(i * spacing, -abs(angle_offset) * spacing * 0.1)

		enemy_instance.position = position_offset.rotated(deg_to_rad(angle_offset))
		add_child(enemy_instance)
