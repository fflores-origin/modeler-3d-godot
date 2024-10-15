extends Node3D

@onready var body = $body
@onready var collision = $body/body_collision
@onready var mesh = $body/body_mesh

@onready var txt_x = $menu/menu_container_vertical/menu_x/txt_value
@onready var txt_y = $menu/menu_container_vertical/menu_y/txt_value
@onready var txt_z = $menu/menu_container_vertical/menu_z/txt_value

func _ready():
	txt_x.text = format_float(mesh.mesh.size.x)
	txt_y.text = format_float(mesh.mesh.size.y)
	txt_z.text = format_float(mesh.mesh.size.z)

# EJE X
func _on_button_pressed() -> void:
	resize_mesh("x", true);
	
func _on_btn_down_x_pressed() -> void:
	resize_mesh("x", false);

# EJE Y
func _on_btn_down_y_pressed() -> void:
	resize_mesh("y", false);

func _on_btn_add_y_pressed() -> void:
	resize_mesh("y", true);
	
# EJE Z
func _on_btn_down_z_pressed() -> void:
	resize_mesh("z", false);

func _on_btn_add_z_pressed() -> void:
	resize_mesh("z", true);


func format_float(value:float) -> String:
	return str(snapped(value, 0.01)) + " Mtrs"

func resize_mesh( axis:String, isAdd:bool) -> void:
	
	if isAdd:
		mesh.mesh.size[axis] += .1
	else:
		if mesh.mesh.size[axis] > 0:
			mesh.mesh.size[axis] -= .1

	var txt_value:TextEdit = get_node("menu/menu_container_vertical/menu_" + axis + "/txt_value")
	
	txt_value.text = format_float(mesh.mesh.size[axis])
