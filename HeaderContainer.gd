tool

extends GridContainer

export var column_header_path = ""

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
	var column_header_obj = load(column_header_path).instance()
	column_header_obj.index = index
	column_header_obj.text = column_name
	column_header_obj.name = "COLUM_%d"%[index]
	self.add_child(column_header_obj, true)
	column_header_obj.owner = self
	return column_header_obj
