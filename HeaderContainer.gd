tool

extends GridContainer

func update_headers(column_headers, column_header_path):
	self.columns = column_headers.size()
	var curr_head_count = self.get_child_count()
	for n in range(curr_head_count, column_headers.size()):
		add_new_column(n, column_header_path)
	for n in range(column_headers.size(), curr_head_count):
		self.remove_child(self.get_child(n))
	print(self.get_child_count())
	var children = self.get_children() as Array
	for i in column_headers.size():
		children[i].text = column_headers[i]
		
func add_new_column(index, column_header_path):
	var column_header_obj = load(column_header_path).instance()
	column_header_obj.index = index
	column_header_obj.name = "COLUM_%d"%[index]
	self.add_child(column_header_obj, true)
	column_header_obj.owner = self
	return column_header_obj

