@tool
extends Node3D

@export var flower_head : MeshInstance3D
@export var seed : int = 0:
	set(new_seed):
		seed = new_seed
		set_rng()

var rng : RandomNumberGenerator

func initialize(rng:RandomNumberGenerator) -> void:
	flower_head.initialize(rng)

func set_rng() -> void:
	if not rng:
		rng = RandomNumberGenerator.new()
		rng.seed = seed
		initialize(rng)

func _ready() -> void:
	set_rng()
