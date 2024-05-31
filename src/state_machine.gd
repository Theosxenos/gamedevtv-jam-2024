class_name StateMachine extends Node

@export var current_state: BaseState

var states: Dictionary = {}

func _ready() -> void:
	for c in get_children():
		if c is BaseState:
			states[c.name] = c

	if current_state:
		current_state.enter_state()

func _process(delta: float) -> void:
	current_state.process_state(delta)
	
	
func _physics_process(delta: float) -> void:
	current_state.physics_process_state(delta)
	
	
func _input(event: InputEvent) -> void:
	current_state.input_state(event)
	
	
func switch_state(new_state: BaseState) -> void:
	if not new_state or not (new_state is BaseState):
		return
		
	current_state.exit_state()
	current_state = new_state
	current_state.enter_state()
