tool
extends PanelContainer

signal CLICK_ROW(value)


# ................... Export Shared Variables ..................
export (String, FILE, "*.tscn") var column_header_path = "res://addons/godot_table/Column/ColumnHeader.tscn"
export (String, FILE, "*.tscn") var data_template_path = "res://addons/godot_table/Data/Data.tscn"
export (Array, String) var column_headers setget set_column_headers
export(Array, Array, String) var row_strings setget set_row_strings

var table_data  = preload("TableData.gd").new()
var tableContainer  = preload("TableContainer.tscn").instance()
		
func set_column_headers(new_header):
	column_headers = new_header
	if table_data.get_column_size() != column_headers.size():
		table_data.set_column_size(column_headers.size())
		_update_row_strings()
	tableContainer.show_header(column_headers, column_header_path)
	
func set_row_strings(new_row_strings : Array):
	table_data.set_string_data(new_row_strings)
	_update_row_strings()

func set_rows_data(new_row_data : Array):
	table_data.set_row_data(new_row_data)
	_update_row_strings()
	
func _ready():
	self.add_child(tableContainer, true)
	
func _update_row_strings():
	row_strings = table_data.get_string_data()
	property_list_changed_notify()
	tableContainer.show_data(table_data, data_template_path)
	
#	tableContainer.init_tree()
#	tableContainer.set_template_path(column_header_path, data_template_path)
##
## Called when the node enters the scene tree for the first time.
#func _ready():
#	for cd in tableContainer.headerContainer.get_children():
#		if cd.get_class() == "ColumnHeader":
#			cd.connect("COLUMN_SORT", self, "_sort_by_column")
#	tableContainer.connect("CLICK_ROW", self, "_on_RowButtonContainer_CLICK_ROW")
#
#func _init_tree():
#	tableContainer = preload_tableContainer.instance()
#	self.add_child(tableContainer, true)

	#tableContainer.init_tree()
	#tableContainer.set_template_path(column_header_path, data_template_path)
#
#func _set_column_headers(new_header):
#	if column_header_path == "":
#		return
#	column_headers = new_header
#	tableContainer.set_header(column_headers)
#
#func set_rows(new_rows):
#	valid_row_count = new_rows.size()
#	_row_datas.clear()
#	for new_row in new_rows:
#		_row_datas.append(RowData.new().set_data(new_row))
#	rows.clear()
#	for row_data in _row_datas:
#		rows.append(row_data.get_datas())
#	tableContainer.show_rows(_row_datas)
#
#func set_min_row_count(count):
#	min_row_count = count
#	if min_row_count > _row_datas.size():
#		for i in range(_row_datas.size(), count):
#			_row_datas.append(RowData.new(column_headers.size()))
#		rows.clear()
#		for row_data in _row_datas:
#			rows.append(row_data.get_datas())
#		tableContainer.show_rows(_row_datas)
#
#func _on_RowButtonContainer_CLICK_ROW(value):
#	emit_signal("CLICK_ROW", value)
