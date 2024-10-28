extends Node3D

@export_enum("Blue","Red","Green") var color: String;

func _ready() -> void:
	set_cone_color()

func set_cone_color()-> void:
	var cone = get_node("Cone")
	var material = StandardMaterial3D.new()
	match color:
		"Blue":
			material.albedo_color = Color.BLUE
		"Red":
			material.albedo_color = Color.RED
		"Green":
			material.albedo_color = Color.GREEN
	cone.material_override = material
