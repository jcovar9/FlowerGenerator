class_name flower_object
extends Node3D

var rng : RandomNumberGenerator
var stem : stem_object
var flower_head := MeshInstance3D.new()


func _init(flower_shader:Shader, new_rng:RandomNumberGenerator, new_stem:stem_object) -> void:
	flower_head.mesh = SphereMesh.new()
	flower_head.mesh.is_hemisphere = true
	flower_head.mesh.material = ShaderMaterial.new()
	flower_head.mesh.material.shader = flower_shader
	flower_head.rotate_x(deg_to_rad(-90))
	flower_head.scale = Vector3(0.1, 0.1, 0.1)
	add_child(flower_head)
	rng = new_rng
	stem = new_stem

func update_pos_and_rot() -> void:
	#mesh.material.set_shader_parameter("position", stem.get_stem_tip())
	#mesh.material.set_shader_parameter("angle", stem.get_stem_tip_dir())
	#look_at_from_position(stem.get_stem_tip(), stem.get_stem_tip() + stem.get_stem_tip_dir())
	position = Vector3.ZERO
	look_at(stem.get_stem_tip_dir())
	position = stem.get_stem_tip()

func _ready() -> void:
	update_pos_and_rot()
