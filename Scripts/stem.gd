class_name stem
extends Node3D

var stem_mesh := MeshInstance3D.new()
var pointing_towards : Vector3

var height : float
var start_radius : float
var end_radius : float
var xcurve : Array
var zcurve : Array

func _init(stem_shader:Shader, rng:RandomNumberGenerator, pos:Vector3, point_towards:Vector3) -> void:
	stem_mesh.mesh = TubeTrailMesh.new()
	stem_mesh.mesh.material = ShaderMaterial.new()
	#stem_mesh.mesh.material.shader = stem_shader
	xcurve = [rng.randf_range(-3.0, 3.0), rng.randf_range(-3.0, 3.0), rng.randf_range(-3.0, 3.0)]
	zcurve = [rng.randf_range(-3.0, 3.0), rng.randf_range(-3.0, 3.0), rng.randf_range(-3.0, 3.0)]
	height = rng.randf_range(1.0, 2.0)
	start_radius = rng.randf_range(0.05, 0.15)
	end_radius = rng.randf_range(0.015, 0.025)
	stem_mesh.mesh.material.set_shader_parameter("xcurve", xcurve)
	stem_mesh.mesh.material.set_shader_parameter("zcurve", zcurve)
	stem_mesh.mesh.material.set_shader_parameter("height", height)
	stem_mesh.mesh.material.set_shader_parameter("startRadius", start_radius)
	stem_mesh.mesh.material.set_shader_parameter("endRadius", end_radius)
	stem_mesh.rotate_x(deg_to_rad(-90))
	rotate_x(deg_to_rad(90))
	add_child(stem_mesh)
	position = pos
	pointing_towards = point_towards

func get_curve_tip() -> Vector3:
	var stem_tip_x := get_curve_value(xcurve, height)
	var stem_tip_z := get_curve_value(zcurve, height)
	var stem_tip := Vector3(stem_tip_x, height, stem_tip_z)
	var stem_tip_rotated := stem_tip.rotated(Vector3(1,0,0), stem_tip.angle_to(pointing_towards))
	return stem_tip_rotated

func get_next_curve_pos() -> Vector3:
	var stem_tip_x := get_curve_value(xcurve, height)
	var stem_tip_z := get_curve_value(zcurve, height)
	var stem_tip := Vector3(stem_tip_x, height, stem_tip_z)
	
	var stem_tip_x_offset := get_curve_value(xcurve, height - 0.01)
	var stem_tip_z_offset := get_curve_value(zcurve, height - 0.01)
	var stem_tip_offset := Vector3(stem_tip_x_offset, height - 0.01, stem_tip_z_offset)
	
	var dir := stem_tip - stem_tip_offset
	return dir.normalized()

func get_curve_value(curve:Array, y_value:float) -> float:
	return (sin(y_value * curve[0]) + sin(y_value * curve[1]) + sin(y_value * curve[2])) * 0.1

func _ready() -> void:
	pass
