extends Node3D


@onready var nodeContainer = $NodeContainer

const cubeMesh = "res://scenes/baseMeshs/cubeMesh.tscn"
const cilinderMesh = "res://scenes/baseMeshs/cilinderMesh.tscn"
const sphereMesh = "res://scenes/baseMeshs/sphereMesh.tscn"

var url = "http://localhost:7000/api";
var objectsHierachy = []

func _ready():
	
	# test request
	var http = HTTPRequest.new();
	add_child(http);
	# conecto una señal para esperar la respuesta
	http.request_completed.connect(Callable(self, "_on_request_completed"))
	http.request(url)

func _on_request_completed(result: int, response_code: int, header: Array, body: PackedByteArray):
	if response_code == 200:
		print(result);
		print("header: ", header)
		print("result: ", result)
		print("body: ", body.get_string_from_utf8())
	else:
		print("error", response_code)
	pass

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
