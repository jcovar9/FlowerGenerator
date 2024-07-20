class_name Flower
extends Node3D

var root_position : Vector3
var number_petals : int = 2
var petal_length : float = 0.1

func _init(pos : Vector3) -> void:
	root_position = pos
