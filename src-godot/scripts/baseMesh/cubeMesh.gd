extends Node3D

@onready var editable_object = $"."

@onready var body: StaticBody3D = $body
@onready var collision: CollisionShape3D = $body/body_collision
@onready var mesh: MeshInstance3D = $body/body_mesh

@onready var txt_x: TextEdit = $menu/menu_container_dimensions/menu_x/txt_value
@onready var txt_y: TextEdit = $menu/menu_container_dimensions/menu_y/txt_value
@onready var txt_z: TextEdit = $menu/menu_container_dimensions/menu_z/txt_value

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
	return str(snapped(value, 0.01) * 100) + " CMS"

func resize_mesh( axis:String, isAdd:bool) -> void:
	
	if isAdd:
		mesh.mesh.size[axis] += .01
		
	else:
		if mesh.mesh.size[axis] > 0:
			mesh.mesh.size[axis] -= .01

	var txt_value:TextEdit = get_node("menu/menu_container_dimensions/menu_" + axis + "/txt_value")
	txt_value.text = format_float(mesh.mesh.size[axis])

func move_mesh( axis:String, isAdd:bool) -> void:
	var direction = -0.1 if isAdd else 0.1
	match axis:
		"x":
			self.translate(Vector3(direction, 0, 0)) 
		"y":
			self.translate(Vector3(0,direction, 0)) 
		"z":
			self.translate(Vector3(0, 0, direction)) 

	var txt_value:TextEdit = get_node("menu/menu_container_postions/menu_"+axis+"/txt_value")
	txt_value.text = format_float(mesh.global_position[axis])

func _on_btn_position_x_down_pressed() -> void:
	move_mesh("x",true);

func _on_btn_position_x_add_pressed() -> void:
	move_mesh("x",false);

func _on_btn_position_y_down_pressed() -> void:
	move_mesh("y",true);

func _on_btn_position_y_add_pressed() -> void:
	move_mesh("y",false);


func _on_btn_position_z_down_pressed() -> void:
	move_mesh("z",true);

func _on_btn_position_z_add_pressed() -> void:
	move_mesh("z",false);
