class_name flower_head
extends Node3D

var rng : RandomNumberGenerator
var stem_object : stem
var flower_head_mesh := MeshInstance3D.new()

func set_flower_head(flower_head_shader:Shader) -> void:
	flower_head_mesh.mesh = SphereMesh.new()
	flower_head_mesh.mesh.is_hemisphere = true
	flower_head_mesh.mesh.material = ShaderMaterial.new()
	flower_head_mesh.mesh.material.shader = flower_head_shader
	flower_head_mesh.rotate_x(deg_to_rad(-90))
	flower_head_mesh.scale = Vector3(0.1, 0.1, 0.1)
	add_child(flower_head_mesh)

func _init(flower_head_shader:Shader, new_rng:RandomNumberGenerator, new_stem:stem) -> void:
	set_flower_head(flower_head_shader)
	rng = new_rng
	stem_object = new_stem

#func update_pos_and_rot() -> void:
	#position = Vector3.ZERO
	#look_at(stem_object.get_stem_tip_dir())
	#position = stem_object.get_stem_tip()

func _ready() -> void:
	#update_pos_and_rot()
	pass


class flower_petal extends Node3D:
	var petal_mesh := MeshInstance3D.new()
	func _init() -> void:
		pass
