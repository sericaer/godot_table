tool
extends GridContainer

#export var template_path = ""
#export var datas = []
#
#func clear_rows():
#	for child in self.get_children():
#		self.remove_child(child)
#
#func set_rows(rows, template_path):
#	datas = rows
#	for row_index in rows.size():
#		for col_index in rows[row_index].size():
#			var data = rows[row_index][col_index]
#			add_new_table_data_item(row_index, col_index, data)
#
#func add_new_table_data_item(row, column, data):
#	var data_obj = load(template_path).instance()
#	data_obj.name = "DATA_%d_%d"%[row, column]
#	data_obj.text = String(data)
#	self.add_child(data_obj)
#
#func sort_column(cmp):
#	datas.sort_custom(cmp, "sort")
#	clear_rows()
#	set_rows(datas, template_path)
#
#func get_row_data(index):
#	return datas[index]

func show_rows(labels : Array):
	for child in self.get_children():
		self.remove_child(child)
	for label_row in  labels:
		print(label_row)
		for label in label_row:
			print(label)
			self.add_child(label)
	
