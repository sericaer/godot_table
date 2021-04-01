tool

extends GridContainer

func update_headers(column_headers, column_header_path):
	_update_header_count(column_headers.size(), column_header_path)
	var children = self.get_children() as Array
	for i in column_headers.size():
		children[i].text = column_headers[i]
		
func add_new_column(index, column_header_path):
	var column_header_obj = load(column_header_path).instance()
	column_header_obj.index = index
	column_header_obj.name = "COLUM_%d"%[index]
	self.add_child(column_header_obj, true)
	print("add column[", column_header_obj.name, "]")
	return column_header_obj

func _update_header_count(var new_size :int, column_header_path):
	self.columns = new_size
	var curr_head_count = self.get_child_count()
	for n in range(curr_head_count, new_size):
		add_new_column(n, column_header_path)
	var need_removes = []
	for n in range(new_size, curr_head_count):
		need_removes.push_back(self.get_child(n))
	for elem in need_removes:
		print("delete column[", elem.name, "]")
		elem.queue_free()
