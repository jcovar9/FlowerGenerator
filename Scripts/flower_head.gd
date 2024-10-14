extends MeshInstance3D

@export var petal : MeshInstance3D

func initialize(rng:RandomNumberGenerator) -> void:
	var xz_scale := rng.randf_range(0.05, 0.15)
	var y_scale := rng.randf_range(0.01, 0.15)
	
	scale = Vector3(xz_scale, y_scale, xz_scale)
	
	petal.initialize(rng)


func _ready() -> void:
	pass
