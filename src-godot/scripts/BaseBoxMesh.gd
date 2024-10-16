extends StaticBody3D

@onready var collision = $Collision
@onready var mesh = $Mesh
@onready var ray01 = $RayCast3D

@export var shape_scale = Vector3(1,1,1)
@export var shape_mesh = Vector3(1,1,1)

func _ready():
	collision.scale = shape_scale
	mesh.scale = shape_mesh


func setBoxShapeSize():
	var box : BoxShape3D = BoxShape3D.new()
	box.extents.x = self.width/2
	box.extents.y = self.height/2
	box.extents.z = self.depth/2
	return box
