@tool
extends Node3D

@export var seed : int = 0:
	set(new_seed):
		seed = new_seed
		if root_stem:
			root_stem.queue_free()
			create_root_stem()

@export var stem_shader : Shader
var root_stem : stem

@export var flower_head_shader : Shader
@export var petal_shader : Shader

var rng := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_root_stem()

func create_root_stem() -> void:
	rng.set_seed(seed)
	root_stem = stem.new(stem_shader, flower_head_shader, petal_shader, rng, Vector3.ZERO, Vector3(0,1,0))
	add_child(root_stem)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
