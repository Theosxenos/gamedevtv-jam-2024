class_name EnemySpawner extends Node2D


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
	
	
func _process(delta: float) -> void:
	_game_time += delta
	
	for i in spawns.size():
		var spawn: SpawnInfo = spawns[i]
		var spawn_id: String = "Spawn%s" % i
		var t = _active_waves.keys()
		if spawn_id in _active_waves.keys():
			if spawn.time_stop >= _game_time and not spawn.continous:
				var timer :=  (_active_waves[spawn_id] as Timer)
				timer.stop()
				timer.free()
				
				_active_waves.erase(spawn_id)
				spawns.remove_at(i)
		elif _game_time >= spawn.time_start:# and (_game_time <= spawn.time_stop or spawn.continous):
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
	
	for i in spawn.spawn_amount:
		spawn_enemy(spawn.enemy_scene, spawn_points)
		await get_tree().create_timer(0.002).timeout


func spawn_enemy(enemy_scene: PackedScene, spawn_points: Array) -> void:
	var enemy: Node2D = enemy_scene.instantiate()
	if spawn_points.size() > 0:
		enemy.global_position = spawn_points.pick_random()

	_parent.add_child(enemy)


func _on_spawn_timer_timeout(enemy_scene: PackedScene, spawn_points: Array) -> void:
	var enemy: Node2D = enemy_scene.instantiate()
	if spawn_points.size() > 0:
		enemy.global_position = spawn_points.pick_random()

	_parent.add_child(enemy)
	#_parent.add_child(enemy_scene.instantiate())
