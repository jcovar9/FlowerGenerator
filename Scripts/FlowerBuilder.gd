@tool
extends Node3D

@export var seed : int = 0:
	set(new_seed):
		seed = new_seed
		rng.set_seed(seed)
		stem.update_seed_data()
		flower.update_pos_and_rot()

@export
var stem_shader : Shader
var stem : stem_object
var rng := RandomNumberGenerator.new()
@export
var flower_shader : Shader
var flower : flower_object

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.set_seed(seed)
	stem = stem_object.new(stem_shader, rng)
	add_child(stem)
	flower = flower_object.new(flower_shader, rng, stem)
	add_child(flower)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
