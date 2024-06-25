extends Node

@onready var nodeContainer = $NodeContainer

const cubeMesh = "res://scenes/baseMeshs/cubeMesh.tscn"
const cilinderMesh = "res://scenes/baseMeshs/cilinderMesh.tscn"
const sphereMesh = "res://scenes/baseMeshs/sphereMesh.tscn"

var objectsHierachy = []

func addNewBox():
	var scene = ResourceLoader.load(cubeMesh)
	if scene is PackedScene:
		var instance = scene.instantiate()
		nodeContainer.add_child(instance)
		
