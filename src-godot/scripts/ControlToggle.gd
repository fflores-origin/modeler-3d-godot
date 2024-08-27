extends Control

@onready var toggleButton = $menuToggeable/btnMenuToggle
@onready var menuItemsContainer = $menuToggeable/menuToggleItems
@onready var horizontalMenuContainer = $menuHorizontal

# Variable para rastrear el estado del menú
var is_collapsed = false

func _ready():
	toggleButton.pressed.connect(_onToggleButtonPressed)
	_collapseMenu()
	formatMenu(horizontalMenuContainer)
	
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
	
func formatMenu(menu: BoxContainer):
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0,0,0)
	menu.add_theme_stylebox_override("normal",style)
