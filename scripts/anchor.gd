extends Node2D

#func _process(delta: float) -> void:
	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#get_parent().global_position = get_viewport().get_mouse_position()
