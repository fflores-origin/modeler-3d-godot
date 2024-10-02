extends Control

var url = "http://localhost:7000/api/users";

# references
@onready var userInput = $user_input
@onready var txtUser = $user_input/txt_user
@onready var txtUserError = $user_input/lbl_user/lbl_user_error

@onready var passInput = $password_input
@onready var txtPass = $password_input/txt_password
@onready var txtPassError = $password_input/lbl_password/lbl_password_error

@onready var btnLogin = $btn_login
@onready var btnCancel = $btn_cancel

@onready var loading = $loading

var http: HTTPRequest;
var rotation_speed = 90.0

func _process(delta):
	loading.rotation_degrees += rotation_speed * delta

func clearErrors():
	txtPassError.text = "";
	txtUserError.text = "";

func _on_btn_login_pressed():
	
	clearErrors();
	
	if txtUser.text == "":
		txtUserError.text = "User can't be null";
		return
		
	if txtPass.text == "":
		txtPassError.text = "Password can´t be null"
		return
	
	var loginRequest = {}
	loginRequest.username = txtUser.text;
	loginRequest.password = txtPass.text;
	
	var json = JSON.stringify(loginRequest)
	
	loadingShow()
	
	http = HTTPRequest.new();
	add_child(http);
	http.request_completed.connect(_loginComplete);
	var loginUrl = url + "/login"
	print(loginUrl)
	var headers = ["Content-Type: application/json"]
	http.request(loginUrl, headers, HTTPClient.METHOD_POST, json);
	
func _loginComplete(result: int, response_code: int, header: Array, body: PackedByteArray):
	if response_code == 200:
		print(result);
		print("header: ", header)
		print("result: ", result)
		print("body: ", body.get_string_from_utf8())
	else:
		print("error", response_code)
	
	loadingHide();
	remove_child(http);

func loadingShow():
	loading.visible = true;
	
func loadingHide():
	loading.visible = false;
