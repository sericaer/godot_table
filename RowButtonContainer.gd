tool

extends VBoxContainer

func set_rows(buttons:Array):
	for child in self.get_children():
		self.remove_child(child)
	for button in buttons:
		if button.get_parent() == null:
			add_child(button)
