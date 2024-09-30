@tool
extends Node3D

@export var seed : int = 0:
	set(new_seed):
		seed = new_seed
		rng.set_seed(seed)
		stem_object.queue_free()
		stem_object = stem.new(stem_shader, rng, Vector3.ZERO, Vector3.UP)
		add_child(stem_object)

@export
var stem_shader : Shader
var stem_object : stem
var rng := RandomNumberGenerator.new()
@export
var flower_shader : Shader
#var flower : flower_head

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.set_seed(seed)
	stem_object = stem.new(stem_shader, rng, Vector3.ZERO, Vector3.UP)
	add_child(stem_object)
	#flower = flower_head.new(flower_shader, rng, stem_object)
	#add_child(flower)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
