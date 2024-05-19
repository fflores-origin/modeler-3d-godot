extends Control

@onready var toggleButton = $VBoxContainer/ToggleBtn
@onready var menuItemsContainer = $VBoxContainer/MenuItemsContainer

# Variable para rastrear el estado del menú
var is_collapsed = false

func _ready():
	
	toggleButton.pressed.connect(_onToggleButtonPressed)
	_collapseMenu()
	
func _onToggleButtonPressed():
	if is_collapsed:
		_expandMenu()
	else:
		_collapseMenu()
		
func _collapseMenu():
	menuItemsContainer.visible = false
	is_collapsed = true
	toggleButton.text = "Expandir"
	
func _expandMenu():
	menuItemsContainer.visible = true
	is_collapsed = false
	toggleButton.text = "Colapsar"
