tool
extends GridContainer

class_name DataContainer

export var template_path = ""
export var datas = []

func clear_rows():
	for child in self.get_children():
		self.remove_child(child)
	pass

func set_rows(rows, column_size):
	datas = rows
	self.columns = column_size
	for row_index in rows.size():
		for col_index in range(column_size):
			var data = rows[row_index][col_index]
			add_new_table_data_item(row_index, col_index, data)
	pass
		
func add_new_table_data_item(row, column, data):
		var data_obj = load(template_path).instance()
		data_obj.name = "DATA_%d_%d"%[row, column]
		data_obj.text = String(data)
		self.add_child(data_obj)
#		return data_obj
		

func sort_column(cmp):
	datas.sort_custom(cmp, "sort")
	clear_rows()
	set_rows(datas, self.columns)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
