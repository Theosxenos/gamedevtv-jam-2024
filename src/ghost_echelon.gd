extends Node2D

# Adjustable properties
@export var spacing : Vector2 = Vector2(100, 50) # Spacing between objects (x, y)
@export var starting_position : Vector2 = Vector2(0, 0) # Starting position of the first object
@export var is_hollow : bool = false # Toggle for hollow formation

# Array of objects to organize
var objects : Array = []

func _ready():
	# Call the function to organize objects into an echelon formation
	organize_into_echelon()

func organize_into_echelon():
	var current_position : Vector2 = starting_position

	var row = 0
	var col = 0

	for i in range(objects.size()):
		# Get the current object
		var obj = objects[i]

		# Skip the middle position if hollow formation is enabled
		if is_hollow and row == col:
			row += 1
			col = 0
			current_position.x = starting_position.x
			current_position.y += spacing.y
			i -= 1
			continue

		# Set the position of the current object
		obj.position = current_position

		# Update the position for the next object
		current_position.x += spacing.x
		col += 1

		# Move to the next row if this row is filled
		if col > row:
			row += 1
			col = 0
			current_position.x = starting_position.x
			current_position.y += spacing.y

# Example of adding objects to the array
func add_object(obj: Node2D):
	objects.append(obj)
	add_child(obj)

# Example usage
func _init():
	for i in range(10): # Create 5 objects
		var scene: PackedScene = preload("res://assets/character/enemy/ghost/ghost.tscn")
		var new_object         = scene.instantiate()
		add_object(new_object)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot"):
		#for c in get_children():
			#c.queue_free()
	
		organize_into_echelon()
