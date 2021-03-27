tool

extends VBoxContainer

func set_rows(row_count):
	for child in self.get_children():
		self.remove_child(child)
	for index in range(row_count):
		var btn = Button.new()
		btn.name = str(index)
		btn.rect_min_size = Vector2(0, 34)
		add_child(btn)
