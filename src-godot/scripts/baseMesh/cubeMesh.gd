extends Node3D

@onready var body = $StaticBody3D
@onready var collision = $StaticBody3D/CollisionShape3D
@onready var mesh = $StaticBody3D/MeshInstance3D

var x = 0
var y = 0
var z = 0

func _ready():
	pass

func _on_button_pressed():
	mesh.mesh.size.x += 1

func _on_button_2_pressed():
	if mesh.mesh.size.x > 0:
		mesh.mesh.size.x -= 1
