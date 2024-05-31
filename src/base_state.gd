class_name BaseState extends Node

var state_machine: StateMachine

func _ready() -> void:
	state_machine = get_parent()
	process_mode = Node.PROCESS_MODE_DISABLED

func process_state(_delta: float) -> void:
	# State-specific process logic
	pass

func physics_process_state(_delta: float) -> void:
	# State-specific physics process logic
	pass

func input_state(_event: InputEvent) -> void:
	# State-specific input logic
	pass

func enter_state() -> void:
	# Logic to run when the state is entered
	pass

func exit_state() -> void:
	# Logic to run when the state is exited
	pass
