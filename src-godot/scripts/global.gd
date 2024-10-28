extends Node

var actual_object: Node3D = null
@export var urlBase = "http://localhost:7000/api";

var scene_models: Array = []

func set_actual_object(model: Node3D):
	print('ACTUAL: ', model)
	actual_object = model;

func add_model(model: Node3D):
	scene_models.append(model)
