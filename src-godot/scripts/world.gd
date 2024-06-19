extends Node

@onready var camera = $Camera3D;
@onready var menu = $viewportMenu;
@onready var nodeContainer = $NodeContainer

func _ready():
	pass
	

func addNewBox():
	print("add new box")
	var meshContainer = StaticBody3D.new()
	meshContainer.name = "Box01"
	
	var mesh = MeshInstance3D.new()
	mesh.name = "MeshBox01"
	
	var boxMeshShape = BoxMesh.new()
	mesh.mesh = boxMeshShape
	
	var boxCollisionShape = BoxShape3D.new()
	boxCollisionShape.extents = Vector3(1, 1, 1)
	
	var collision = CollisionShape3D.new()
	collision.name = "CollisionBox01"
	collision.shape = boxCollisionShape
	
	meshContainer.add_child(mesh)
	meshContainer.add_child(collision)
	
	
	nodeContainer.add_child(meshContainer)
	
