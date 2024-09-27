class_name stem_object
extends MeshInstance3D

var rng : RandomNumberGenerator
var xcurve : Array
var zcurve : Array

func _init(stem_shader:Shader, new_rng:RandomNumberGenerator) -> void:
	mesh = TubeTrailMesh.new()
	mesh.material = ShaderMaterial.new()
	mesh.material.shader = stem_shader
	rng = new_rng
	update_seed_data()

func update_seed_data() -> void:
	xcurve = [rng.randf_range(-3.0, 3.0), rng.randf_range(-3.0, 3.0), rng.randf_range(-3.0, 3.0)]
	zcurve = [rng.randf_range(-3.0, 3.0), rng.randf_range(-3.0, 3.0), rng.randf_range(-3.0, 3.0)]
	mesh.material.set_shader_parameter("xcurve", xcurve)
	mesh.material.set_shader_parameter("zcurve", zcurve)
	
	var height = rng.randf_range(1.0, 2.0)
	mesh.material.set_shader_parameter("height", height)
	
	var start_radius = rng.randf_range(0.05, 0.15)
	mesh.material.set_shader_parameter("startRadius", start_radius)
	
	var end_radius = rng.randf_range(0.015, 0.025)
	mesh.material.set_shader_parameter("endRadius", end_radius)

func get_stem_tip() -> Vector3:
	var height : float = mesh.material.get_shader_parameter("height")
	var stem_tip_x := get_curve_value(xcurve, height)
	var stem_tip_z := get_curve_value(zcurve, height)
	return Vector3(stem_tip_x, height, stem_tip_z)

func get_stem_tip_dir() -> Vector3:
	var height : float = mesh.material.get_shader_parameter("height")
	var stem_tip_x := get_curve_value(xcurve, height)
	var stem_tip_z := get_curve_value(zcurve, height)
	var stem_tip := Vector3(stem_tip_x, height, stem_tip_z)
	
	var stem_tip_x_offset := get_curve_value(xcurve, height - 0.01)
	var stem_tip_z_offset := get_curve_value(zcurve, height - 0.01)
	var stem_tip_offset := Vector3(stem_tip_x_offset, height - 0.01, stem_tip_z_offset)
	
	var dir := stem_tip - stem_tip_offset
	return dir.normalized()

func get_curve_value(curve:Array, height:float) -> float:
	return (sin(height * curve[0]) + sin(height * curve[1]) + sin(height * curve[2])) * 0.1
