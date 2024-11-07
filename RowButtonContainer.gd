@tool

extends VBoxContainer

var btn_hover:StyleBoxFlat
var btn_pressed:StyleBoxFlat

var row_one_normal:StyleBoxFlat
var row_two_normal:StyleBoxFlat

func set_rows(row_count):
	for child in self.get_children():
		self.remove_child(child)
	for index in range(row_count):
		var btn = Button.new()
		btn.name = str(index)
		btn.custom_minimum_size = Vector2(0, 34)
		
		# check if row is even or odd
		if not index & 1:
			btn.add_theme_stylebox_override("normal", row_one_normal)
		else:
			btn.add_theme_stylebox_override("normal", row_two_normal)
		
		btn.add_theme_stylebox_override("hover", btn_hover)
		btn.add_theme_stylebox_override("pressed", btn_pressed)
	
		add_child(btn)

func set_style(row_one_normal:StyleBoxFlat, row_two_normal:StyleBoxFlat, btn_hover:StyleBoxFlat, btn_pressed:StyleBoxFlat) -> void:
	self.btn_hover = btn_hover
	self.btn_pressed = btn_pressed
	self.row_one_normal = row_one_normal
	self.row_two_normal = row_two_normal
