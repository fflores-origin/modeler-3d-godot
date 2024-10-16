class_name FreeLookCamera 
extends Camera3D

@onready var drawService = DrawService.new()

@onready var raycast = $RayCast3D
@export var ray_length : float = 10000
var last_hovered: Node3D = null

# Modifier keys' speed multiplier
const SHIFT_MULTIPLIER = 2.5
const ALT_MULTIPLIER = 1.0 / SHIFT_MULTIPLIER


@export_range(0.0, 1.0) var sensitivity: float = 0.25

# Mouse state
var _mouse_position = Vector2(0.0, 0.0)
var _total_pitch = 0.0

# Movement state
var _direction = Vector3(0.0, 0.0, 0.0)
var _velocity = Vector3(0.0, 0.0, 0.0)
var _acceleration = 30
var _deceleration = -10
var _vel_multiplier = 4

# Keyboard state
var _w = false
var _s = false
var _a = false
var _d = false
var _q = false
var _e = false
var _shift = false
var _alt = false

var from : Vector3
var to : Vector3
var left_button_mouse_pressed = false

func _ready():
	$RayCast3D.enabled = true
	add_child(drawService)

# not-used
func set_proyect_ray_proyection():
	var query = PhysicsRayQueryParameters3D.new()
	var camera = get_viewport().get_camera_3d()
	var mouse_position = get_viewport().get_mouse_position()
	from = camera.project_ray_origin(mouse_position)
	to = query.from + camera.project_ray_normal(mouse_position) * 1000

func _input(event):
	# Receives mouse motion
	if event is InputEventMouseMotion:
		_mouse_position = event.relative
	
	# Receives mouse button input
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				left_button_mouse_pressed = event.is_pressed()
				if event.is_pressed():
					print("mouse.event.position: ", event.position)
					from = self.project_ray_origin(event.position)
					to = from + self.project_ray_normal(event.position) * ray_length
		
			MOUSE_BUTTON_RIGHT: # Only allows rotation if right click down
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if event.pressed else Input.MOUSE_MODE_VISIBLE)
			MOUSE_BUTTON_WHEEL_UP: # Increases max velocity
				_vel_multiplier = clamp(_vel_multiplier * 1.1, 0.2, 20)
			MOUSE_BUTTON_WHEEL_DOWN: # Decereases max velocity
				_vel_multiplier = clamp(_vel_multiplier / 1.1, 0.2, 20)

	# Receives key input
	if event is InputEventKey:
		match event.keycode:
			KEY_W:
				_w = event.pressed
			KEY_S:
				_s = event.pressed
			KEY_A:
				_a = event.pressed
			KEY_D:
				_d = event.pressed
			KEY_Q:
				_q = event.pressed
			KEY_E:
				_e = event.pressed
			KEY_SHIFT:
				_shift = event.pressed
			KEY_ALT:
				_alt = event.pressed

func _physics_process(_delta)->void:
	if left_button_mouse_pressed:
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.new()
		query.from = from
		query.to = to
		
		#drawService.line(from, to)
		
		var result = null
		var item = null

		var max_scan = 2
		var counter = 0
		
		while true:
			counter+=1
			# busco intersecciones
			result = space_state.intersect_ray(query)
			
			if !left_button_mouse_pressed or result.is_empty() or counter == max_scan:
				break;
			
			if !result.is_empty() and result["collider"] != null:
				var clicked_object = result["collider"]
				print(clicked_object.name)
				if(has_mesh_instance(clicked_object)):
					Global.set_actual_object(clicked_object)
			
				if clicked_object.name == "scale_x" or clicked_object.name == "scale_y" or clicked_object.name == "scale_z":
					#print("Clicked on gizmo axis: ", clicked_object.name)
					break
				
				var direction:Vector3 = (query.to - query.from).normalized()
				query.from = result["position"] + direction * 0.01
			
		#if !result.is_empty() and result["collider"] != null:
		if Global.actual_object != null:
			changeMeshColor(Global.actual_object)
		else: 
			changeMeshColor(null)

# Updates mouselook and movement every frame
func _process(delta):
	_update_mouselook()
	_update_movement(delta)
	
	#if(left_button_mouse_pressed):
		#print("presionado")
	#else:
		#print("release")


	
func checkColideRaycas() -> void:
	
	if raycast.is_colliding():
		var space_state = get_world_3d().direct_space_state
		print(space_state)
		print('check is_colliding')
		var collider: Node3D = raycast.get_collider()
		if collider != last_hovered:
			if last_hovered != null:
				reset_hover_color(last_hovered)
			apply_hover_color(collider)
			last_hovered = collider
	else:
		if last_hovered != null:
			reset_hover_color(last_hovered)
			last_hovered = null

func changeMeshColor(item: Node3D)-> void:
	if item != null:
		if item != last_hovered:
			#if last_hovered != null:
				#reset_hover_color(last_hovered)
			apply_hover_color(item)
			last_hovered = item

	#else:
		#if last_hovered != null:
			#reset_hover_color(last_hovered)
			#last_hovered = null

func apply_hover_color(collider: Node3D) -> void:
	var mesh = has_mesh_instance(collider)
	if collider is Node3D and mesh != null:
		var material = StandardMaterial3D.new()
		material.albedo_color = Color.AQUAMARINE  # Cambia el color
		mesh.material_override = material

func reset_hover_color(collider: Node3D) -> void:
	var mesh = has_mesh_instance(collider)
	if collider is Node3D  and mesh != null:
		mesh.material_override = null  # Restablece al material original

# Updates camera movement
func _update_movement(delta):
	# Computes desired direction from key states
	_direction = Vector3(
		(_d as float) - (_a as float), 
		(_e as float) - (_q as float),
		(_s as float) - (_w as float)
	)
	
	# Computes the change in velocity due to desired direction and "drag"
	# The "drag" is a constant acceleration on the camera to bring it's velocity to 0
	var offset = _direction.normalized() * _acceleration * _vel_multiplier * delta \
		+ _velocity.normalized() * _deceleration * _vel_multiplier * delta
	
	# Compute modifiers' speed multiplier
	var speed_multi = 1
	if _shift: speed_multi *= SHIFT_MULTIPLIER
	if _alt: speed_multi *= ALT_MULTIPLIER
	
	# Checks if we should bother translating the camera
	if _direction == Vector3.ZERO and offset.length_squared() > _velocity.length_squared():
		# Sets the velocity to 0 to prevent jittering due to imperfect deceleration
		_velocity = Vector3.ZERO
	else:
		# Clamps speed to stay within maximum value (_vel_multiplier)
		_velocity.x = clamp(_velocity.x + offset.x, -_vel_multiplier, _vel_multiplier)
		_velocity.y = clamp(_velocity.y + offset.y, -_vel_multiplier, _vel_multiplier)
		_velocity.z = clamp(_velocity.z + offset.z, -_vel_multiplier, _vel_multiplier)
	
		translate(_velocity * delta * speed_multi)

# Updates mouse look 
func _update_mouselook():
	# Only rotates mouse if the mouse is captured
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_mouse_position *= sensitivity
		var yaw = _mouse_position.x
		var pitch = _mouse_position.y
		_mouse_position = Vector2(0, 0)
		
		# Prevents looking up/down too far
		pitch = clamp(pitch, -90 - _total_pitch, 90 - _total_pitch)
		_total_pitch += pitch
	
		rotate_y(deg_to_rad(-yaw))
		rotate_object_local(Vector3(1,0,0), deg_to_rad(-pitch))

func has_mesh_instance(node: Node3D) -> MeshInstance3D:
	var isEditable = node.has_node("is_editable")
	for child in node.get_children():
		if child is MeshInstance3D and isEditable:
			return child
	return null

func hash_mesh_instance_and_is_editable(node: Node3D)-> MeshInstance3D:
	var isEditable = node.has_node("is_editable")
	#print("isEditable", isEditable)
	for child in node.get_children():
		if child is MeshInstance3D:
			return child
	return null
	
