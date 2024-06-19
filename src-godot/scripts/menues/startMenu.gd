extends Control

@onready var panel = $pnlMain

@onready var btnStartNew = $pnlMain/btnStartNew
@onready var btnStartTemplate = $pnlMain/btnStartTemplate
@onready var btnGalery = $pnlMain/btnGalery

func _ready():
	applyBUtonStyle(btnStartNew)

	
func applyBUtonStyle(btn: Button):
	# Crear un nuevo StyleBoxFlat para el estado normal
	var normal_style = StyleBoxFlat.new()
	normal_style.bg_color = Color(0.8, 0.8, 0.8)
	normal_style.border_color = Color(0.4, 0.4, 0.4)
	normal_style.set_border_width_all(2)
	
	# Asignar el estilo al botón
	btn.add_theme_stylebox_override("normal", normal_style)
	
	# Crear un nuevo StyleBoxFlat para el estado hover
	var hover_style = StyleBoxFlat.new()
	hover_style.bg_color = Color(0.9, 0.9, 0.9)
	hover_style.border_color = Color(0.5, 0.5, 0.5)
	hover_style.set_border_width_all(2)
	
	# Asignar el estilo al botón
	btn.add_theme_stylebox_override("hover", hover_style)
	
	# Crear un nuevo StyleBoxFlat para el estado presionado
	var pressed_style = StyleBoxFlat.new()
	pressed_style.bg_color = Color(0.6, 0.6, 0.6)
	pressed_style.border_color = Color(0.3, 0.3, 0.3)
	pressed_style.set_border_width_all(2)
	
	btn.add_theme_stylebox_override("pressed", pressed_style)
