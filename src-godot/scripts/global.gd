extends Node

var actual_object: Node3D = null

var scene_models: Array = []

func set_actual_object(model: Node3D):
	print('actual', model)
	actual_object = model;

func add_model(model: Node3D):
	scene_models.append(model)
