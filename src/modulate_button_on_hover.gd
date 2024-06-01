extends TextureButton

@export var normal_colour: Color = Color("efdcb3")
@export var hover_colour: Color

func _on_mouse_entered() -> void:
	self_modulate = hover_colour


func _on_mouse_exited() -> void:
	self_modulate = normal_colour
