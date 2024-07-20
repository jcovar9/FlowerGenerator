@tool
extends Node3D

@export var flower_seed : int = 0:
	set(new_flower_seed):
		flower_seed = new_flower_seed
		update_seed_data()
@export var height := 1.0:
	set(new_height):
		height = new_height
		update_height_data()
@export var start_radius := 0.1:
	set(new_start_radius):
		start_radius = new_start_radius
		stem_shader_material.set_shader_parameter("startRadius", start_radius)
@export var end_radius := 0.025:
	set(new_end_radius):
		end_radius = new_end_radius
		stem_shader_material.set_shader_parameter("endRadius", end_radius)

@export
var stem_shader : Shader
var stem_shader_material := ShaderMaterial.new()
var rng := RandomNumberGenerator.new()
var xa : float
var xb : float
var xc : float
var za : float
var zb : float
var zc : float

var stem := MeshInstance3D.new()

func update_seed_data():
	rng.set_seed(flower_seed)
	xa = rng.randf_range(-3.0, 3.0)
	xb = rng.randf_range(-3.0, 3.0)
	xc = rng.randf_range(-3.0, 3.0)
	za = rng.randf_range(-3.0, 3.0)
	zb = rng.randf_range(-3.0, 3.0)
	zc = rng.randf_range(-3.0, 3.0)
	stem_shader_material.set_shader_parameter("xa", xa)
	stem_shader_material.set_shader_parameter("xb", xb)
	stem_shader_material.set_shader_parameter("xc", xc)
	stem_shader_material.set_shader_parameter("za", za)
	stem_shader_material.set_shader_parameter("zb", zb)
	stem_shader_material.set_shader_parameter("zc", zc)

func update_height_data():
	stem.mesh.section_length = height / stem.mesh.sections
	stem_shader_material.set_shader_parameter("height", height)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stem_shader_material.shader = stem_shader
	stem_shader_material.set_shader_parameter("startRadius", start_radius)
	stem_shader_material.set_shader_parameter("endRadius", end_radius)
	
	stem.mesh = TubeTrailMesh.new()
	stem.mesh.sections = 5
	stem.mesh.material = stem_shader_material
	
	update_seed_data()
	update_height_data()
	add_child(stem)
	var stem_top_x : float = (sin(height * xa) + sin(height * xb) + sin(height * xc)) * 0.1
	var stem_top_z : float = (sin(height * za) + sin(height * zb) + sin(height * zc)) * 0.1
	var flower := Flower.new(Vector3(stem_top_x, height, stem_top_z))
