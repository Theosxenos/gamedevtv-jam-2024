class_name SpawnInfo extends Resource

enum SpawnPlaces {DOORS, CORNERS, PLAYER}

@export var enemy_scene: PackedScene
@export var time_start: float
@export var time_stop: float
@export var continous: bool

@export var spawn_amount: int
@export var wave_interval: float
@export var spawn_place: SpawnPlaces

var active: bool
