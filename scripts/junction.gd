class_name Junction
extends Marker2D

@export var leading_junction: Junction
@export var trailing_junction: Junction
@export var point_color: Color

@export var distance_constraint: float = 0:
	set(value):
		distance_constraint = value
		queue_redraw()

var angle_offset: float

func _process(delta: float) -> void:
	if leading_junction and trailing_junction:
		var direction = (leading_junction.position - trailing_junction.position).normalized()
		var rotated_direction = direction.rotated(deg_to_rad(angle_offset))
		position = trailing_junction.position + rotated_direction * trailing_junction.distance_constraint

func _draw() -> void:
	draw_arc(get_viewport_rect().position, 10, 0, 2 * PI, 32, point_color, 2.0)
	draw_distance_constraint_outline(get_viewport_rect().position)

func draw_distance_constraint_outline(point_position) -> void:
	var segments = 25
	var start_angle = 0
	var angle_step = (2 * PI / segments)
	var radius = distance_constraint
	
	for i in range(segments):
		var angle = start_angle + i * angle_step
		var x = point_position.x + cos(angle) * radius
		var y = point_position.y + sin(angle) * radius
		
		draw_circle(Vector2(x, y), 1, Color(1, 1, 1))
