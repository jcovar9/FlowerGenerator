class_name flower_head
extends Node3D

var look_at_target : Vector3

# Flower fields
var flower_head_mesh := MeshInstance3D.new()
var flower_head_shader : Shader

# RNG fields
var rng : RandomNumberGenerator
var xz_scale : float
var y_scale : float

func _init(flower_head_shader:Shader, rng:RandomNumberGenerator, offset:Vector3, look_at_target:Vector3) -> void:
	self.flower_head_shader = flower_head_shader
	self.rng = rng
	self.position = offset
	self.look_at_target = look_at_target
	set_rng_values()
	create_mesh()

func create_mesh() -> void:
	flower_head_mesh.mesh = SphereMesh.new()
	flower_head_mesh.mesh.is_hemisphere = true
	flower_head_mesh.mesh.material = ShaderMaterial.new()
	flower_head_mesh.mesh.material.shader = flower_head_shader
	flower_head_mesh.rotate_x(deg_to_rad(-90))   # align mesh with parent node forward direction
	flower_head_mesh.scale = Vector3(xz_scale, y_scale, xz_scale)
	add_child(flower_head_mesh)

func set_rng_values() -> void:
	xz_scale = rng.randf_range(0.05, 0.15)
	y_scale = rng.randf_range(0.01, 0.15)

func set_shader_values() -> void:
	pass

func _ready() -> void:
	if(look_at_target.x == 0.0 or look_at_target.z == 0.0):
		look_at_target += Vector3(.001,0,0)
	look_at(look_at_target)
