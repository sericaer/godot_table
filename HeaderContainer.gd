@tool

extends GridContainer

@export var column_header_path = ""

var header_normal:StyleBoxFlat
var header_hover:StyleBoxFlat
var header_pressed:StyleBoxFlat

var main_font:Font
var font_size:int = 1

func clear_headers():
	for child in self.get_children():
		self.remove_child(child)
		
func add_headers(column_headers):
	if column_headers.size() == 0:
		return
	self.columns = column_headers.size()
	for n in range(column_headers.size()):
		add_new_column(n, column_headers[n])
		
func add_new_column(index, column_name):
	var column_header_obj = load(column_header_path).instantiate()
	column_header_obj.index = index
	column_header_obj.text = column_name
	column_header_obj.name = "COLUM_%d"%[index]
	
	column_header_obj.add_theme_stylebox_override("normal", header_normal)
	column_header_obj.add_theme_stylebox_override("hover", header_hover)
	column_header_obj.add_theme_stylebox_override("pressed", header_pressed)
	
	column_header_obj.add_theme_font_override("font", main_font)
	column_header_obj.add_theme_font_size_override("font_size", font_size)#
	
	self.add_child(column_header_obj, true)
	column_header_obj.owner = self
	return column_header_obj

func set_style(header_normal:StyleBoxFlat, header_hover:StyleBoxFlat, header_pressed:StyleBoxFlat) -> void:
	self.header_normal = header_normal
	self.header_hover = header_hover
	self.header_pressed = header_pressed

func set_font(main_font:Font, font_size:int) -> void:
	self.main_font = main_font
	self.font_size = font_size
