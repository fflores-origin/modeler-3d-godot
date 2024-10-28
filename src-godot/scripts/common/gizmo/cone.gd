extends Node3D

@export_enum("Blue","Red","Green") var color: String;
@export var cone_name: String;

@onready var body = $Cone/StaticBody3D
@onready var coll = $Cone/StaticBody3D/CollisionShape3D

func _ready() -> void:
	set_cone_name()
	set_cone_color()

func set_cone_name()->void:
	if cone_name != null:
		body.name = cone_name
	
func set_cone_color()-> void:
	var cone = get_node("Cone")
	var material = StandardMaterial3D.new()
	material.no_depth_test = true;
	match color:
		"Blue":
			material.albedo_color = Color.BLUE
		"Red":
			material.albedo_color = Color.RED
		"Green":
			material.albedo_color = Color.GREEN
	cone.material_override = material
	
