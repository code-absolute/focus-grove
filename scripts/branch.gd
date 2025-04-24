class_name Branch
extends Line2D

@export var leading_junction: Junction
@export var trailing_junction: Junction

func _ready() -> void:
	default_color = Color(1, 1, 1)
	width = 10.0

func _process(delta: float) -> void:
	clear_points()
	add_point(leading_junction.position)
	add_point(trailing_junction.position)
