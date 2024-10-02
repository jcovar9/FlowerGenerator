class_name stem
extends Node3D

var stem_mesh := MeshInstance3D.new()
var flower : flower_head
var flower_head_shader : Shader
var pointing_towards : Vector3

var rng:RandomNumberGenerator
var height : float
var start_radius : float
var end_radius : float
var xcurve : Array
var zcurve : Array

func _init(stem_shader:Shader, flower_shader:Shader, rng:RandomNumberGenerator, offset:Vector3, point_towards:Vector3) -> void:
	stem_mesh.mesh = TubeTrailMesh.new()
	stem_mesh.mesh.material = ShaderMaterial.new()
	stem_mesh.mesh.material.shader = stem_shader
	self.flower_head_shader = flower_shader
	self.rng = rng
	set_rng_values()
	set_shader_values()
	stem_mesh.rotate_x(deg_to_rad(-90))  # align mesh with stem node's forward direction
	add_child(stem_mesh)
	position = offset
	pointing_towards = point_towards

func set_rng_values() -> void:
	xcurve = [rng.randf_range(-3.0, 3.0), rng.randf_range(-3.0, 3.0), rng.randf_range(-3.0, 3.0)]
	zcurve = [rng.randf_range(-3.0, 3.0), rng.randf_range(-3.0, 3.0), rng.randf_range(-3.0, 3.0)]
	height = rng.randf_range(1.0, 2.0)
	start_radius = rng.randf_range(0.05, 0.15)
	end_radius = rng.randf_range(0.015, 0.025)

func set_shader_values() -> void:
	stem_mesh.mesh.material.set_shader_parameter("xcurve", xcurve)
	stem_mesh.mesh.material.set_shader_parameter("zcurve", zcurve)
	stem_mesh.mesh.material.set_shader_parameter("height", height)
	stem_mesh.mesh.material.set_shader_parameter("startRadius", start_radius)
	stem_mesh.mesh.material.set_shader_parameter("endRadius", end_radius)

func get_curve_value(curve:Array, y_value:float) -> float:
	return (sin(y_value * curve[0]) + sin(y_value * curve[1]) + sin(y_value * curve[2])) * 0.1

# Gets the position of the stem at a y_value if mesh is pointing up
func get_stem_pos(y_value:float) -> Vector3:
	var stem_tip_x := get_curve_value(xcurve, y_value)
	var stem_tip_z := get_curve_value(zcurve, y_value)
	return Vector3(stem_tip_x, y_value, stem_tip_z)

# Gets the position of the stem at y_value in stem local space
func get_local_stem_pos(y_value:float) -> Vector3:
	var stem_pos : Vector3 = get_stem_pos(y_value)
	return stem_pos.rotated(Vector3.RIGHT, deg_to_rad(-90))

func _ready() -> void:
	#look_at(pointing_towards)
	flower = flower_head.new(flower_head_shader, rng, get_local_stem_pos(height), to_global(get_local_stem_pos(height + 0.01)))
	add_child(flower)
