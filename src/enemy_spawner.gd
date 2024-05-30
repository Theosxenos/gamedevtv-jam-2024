class_name EnemySpawner extends Node2D

signal enemy_spawned(enemy)

@export var level_spawn_positions: Dictionary
@export var spawns: Array[SpawnInfo]

var _active_waves: Dictionary
var _game_time := 0.0
var _parent: Node2D

func _ready() -> void:
	_parent = get_parent()
	
	level_spawn_positions["Doors"] = []
	for p: Marker2D in %Doors.get_children():
		level_spawn_positions["Doors"].append(p.global_position)
		
	level_spawn_positions["Corners"] = []
	for p: Marker2D in %Corners.get_children():
		level_spawn_positions["Corners"].append(p.global_position)


func _process(delta: float) -> void:
	_game_time += delta
	
	for i in range(spawns.size()):
		var spawn: SpawnInfo = spawns[i]
		var spawn_id: int = spawn.get_instance_id()

		if spawn_id in _active_waves.keys():
			if _game_time >= spawn.time_stop and not spawn.continous:
				var timer :=  (_active_waves[spawn_id] as Timer)
				timer.stop()
				timer.free()
				
				_active_waves.erase(spawn_id)
				spawns.remove_at.call_deferred(i)
		elif _game_time >= spawn.time_start:
			spawn_wave(spawn)
			
			var timer := Timer.new()
			add_child(timer)
			
			timer.timeout.connect(spawn_wave.bind(spawn))
			timer.start(spawn.wave_interval)
			
			_active_waves[spawn_id] = timer


func spawn_wave(spawn: SpawnInfo) -> void:
	var spawn_points: Array = []
	if spawn.spawn_place == spawn.SpawnPlaces.DOORS:
		spawn_points = level_spawn_positions["Doors"]
	elif spawn.spawn_place == spawn.SpawnPlaces.CORNERS:
		spawn_points = level_spawn_positions["Corners"]
	
	for i in spawn.spawn_amount:
		spawn_enemy(spawn.enemy_scene, spawn_points)
		await get_tree().create_timer(0.01).timeout


func spawn_enemy(enemy_scene: PackedScene, spawn_points: Array) -> void:
	var enemy: Node2D = enemy_scene.instantiate()
	if spawn_points.size() > 0:
		enemy.global_position = spawn_points.pick_random()
	
	enemy_spawned.emit(enemy)
	
	_parent.add_child(enemy)
