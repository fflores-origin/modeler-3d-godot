extends Control

@onready var panel = $pnlMain

@onready var btnStartNew = $pnlMain/btnStartNew
@onready var btnStartTemplate = $pnlMain/btnStartTemplate
@onready var btnGalery = $pnlMain/btnGalery

func _ready():
	pass

func _process(delta):
	
	
	
	pass
	
	
func applyBUtonStyle():
	var normalStyle = StyleBoxFlat.new()
	normalStyle.bg_color = Color(0.8, 0.8, 0.8)
