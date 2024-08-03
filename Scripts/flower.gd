class_name Flower
extends Node3D

var head_position : Vector3
var flower_head_radius : float = 0.1
@export
var flower_head_shader : Shader
var flower_head_shader_material := ShaderMaterial.new()
var flower_head := MeshInstance3D.new()

func _init(rng : RandomNumberGenerator, pos : Vector3) -> void:
	head_position = pos
	flower_head_shader_material.shader = flower_head_shader
	var mesh := SphereMesh.new()
	mesh.radius = 0.1
	mesh.height = 0.03
	mesh.is_hemisphere = true
	mesh.material = flower_head_shader_material
	flower_head.mesh = mesh
	flower_head.position = head_position
	add_child(flower_head)
