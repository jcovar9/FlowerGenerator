class_name flower_head
extends Node3D

var rng : RandomNumberGenerator
var flower_head_mesh := MeshInstance3D.new()
var position_vec : Vector3
var look_at_target : Vector3

func _init(flower_head_shader:Shader, rng:RandomNumberGenerator, offset:Vector3, look_at_target:Vector3) -> void:
	flower_head_mesh.mesh = SphereMesh.new()
	flower_head_mesh.mesh.is_hemisphere = true
	flower_head_mesh.mesh.material = ShaderMaterial.new()
	flower_head_mesh.mesh.material.shader = flower_head_shader
	flower_head_mesh.rotate_x(deg_to_rad(-90))
	flower_head_mesh.scale = Vector3(0.1, 0.1, 0.1)
	add_child(flower_head_mesh)
	self.rng = rng
	position = offset
	self.look_at_target = look_at_target


func _ready() -> void:
	look_at(look_at_target)
	print(look_at_target)
	pass
