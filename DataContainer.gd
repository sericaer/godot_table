tool
extends GridContainer

export var template_path = ""
export var datas = []

func clear_rows():
	for child in self.get_children():
		self.remove_child(child)

func set_rows(rows, column_size):
	datas = rows
	self.columns = column_size
	for row_index in rows.size():
		for col_index in range(column_size):
			var data = rows[row_index][col_index]
			add_new_table_data_item(row_index, col_index, data)

func add_new_table_data_item(row, column, data):
	var data_obj = load(template_path).instance()
	data_obj.name = "DATA_%d_%d"%[row, column]
	data_obj.text = String(data)
	self.add_child(data_obj)

func sort_column(cmp):
	datas.sort_custom(cmp, "sort")
	clear_rows()
	set_rows(datas, self.columns)

func get_row_data(index):
	return datas[index]
