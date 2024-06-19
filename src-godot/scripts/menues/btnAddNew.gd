extends Button
@onready var viewportMenu = $viewportMenu

#signal add_new_box(data);

func _pressed():
	#emit_signal("addNewBox", "crear nuevo cubo")
	var viewport = find_ancestor_of_type("MainViewPort")
	viewport.addNewBox()
	
	pass

func find_ancestor_of_type(type_name: String):
	var current_node = self
	while current_node:
		print(current_node.name)
		if current_node.name == type_name:
			return current_node
		current_node = current_node.get_parent()
	return null

