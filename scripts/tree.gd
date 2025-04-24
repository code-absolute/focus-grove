extends Node2D

@export var anchor_height = 400.0
@export var branching_threshold = 50
@export var growth_speed = 1.0

@onready var anchor_point: Junction = $AnchorPoint
@onready var base_point: Junction = $BasePoint

var junction_scene = preload("res://scenes/junction.tscn")
var branch_scene = preload("res://scenes/branch.tscn")
var junctions: Array[Junction] = []
var branches: Array[Branch] = []

var threshold_junction: Junction
var time_passed := 0.0
var tree_height = 0.0

func _ready() -> void:
	anchor_point.position.y -= anchor_height
	threshold_junction = base_point
	_add_junction_with_branch(base_point, anchor_point)

func _process(delta: float) -> void:
	
	if(junctions.back().position.y > anchor_point.position.y):
		time_passed += delta
		if time_passed >= 1.0:
			time_passed -= 1.0
			tree_height += 20

		base_point.distance_constraint = lerp(base_point.distance_constraint, tree_height, delta * growth_speed)

	if base_point.distance_constraint > branching_threshold:
		for i in junctions.size() - 1:
			var junction = junctions[i]
			junction.distance_constraint = base_point.distance_constraint - (branching_threshold * (i + 1))
	
		if threshold_junction.distance_constraint > branching_threshold:
			threshold_junction = junctions.back()
			_add_junction_with_branch(threshold_junction, anchor_point)

func _add_junction_with_branch(trailing_junction: Junction, leading_junction: Junction) -> void:
	var junction: Junction = junction_scene.instantiate()
	junction.trailing_junction = trailing_junction
	junction.leading_junction = leading_junction
	junction.angle_offset = randf_range(-20, 20)
	junctions.append(junction)
	add_child(junction)

	var branch: Branch = branch_scene.instantiate()
	branch.trailing_junction = trailing_junction
	branch.leading_junction = junction
	branches.append(branch)
	add_child(branch)
