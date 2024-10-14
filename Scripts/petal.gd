@tool
class_name petal
extends Node3D

@export var normal_face : MeshInstance3D
@export var flipped_face : MeshInstance3D

# RNG fields
var rng : RandomNumberGenerator

func initialize(rng:RandomNumberGenerator) -> void:
	self.rng = rng
	

func _ready() -> void:
	pass
