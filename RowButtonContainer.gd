tool

extends VBoxContainer

func set_rows(disables:Array):
	for child in self.get_children():
		self.remove_child(child)
	for index in range(disables.size()):
		var btn = Button.new()
		btn.name = str(index)
		btn.rect_min_size = Vector2(0, 34)
		btn.disabled = disables[index]
		add_child(btn)

func clear_rows():
	for child in self.get_children():
		self.remove_child(child)
