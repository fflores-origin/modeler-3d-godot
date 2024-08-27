extends Node3D


@onready var nodeContainer = $NodeContainer

const cubeMesh = "res://scenes/baseMeshs/cubeMesh.tscn"
const cilinderMesh = "res://scenes/baseMeshs/cilinderMesh.tscn"
const sphereMesh = "res://scenes/baseMeshs/sphereMesh.tscn"

var objectsHierachy = []

func addNewBox():
	var scene = ResourceLoader.load(cubeMesh);
	addSceneInstance(scene);
		

func addNewCilinder():
	var scene = ResourceLoader.load(cilinderMesh);
	addSceneInstance(scene);
	
func addNewSpere():
	var scene = ResourceLoader.load(sphereMesh);
	addSceneInstance(scene);
	
func addSceneInstance(scene ) -> void:
	if scene is PackedScene:
		var instance = scene.instantiate()
		nodeContainer.add_child(instance)
