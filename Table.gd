tool
extends PanelContainer

signal CLICK_ROW(value)

const TableContainer = preload("res://addons/godot_table/TableContainer.gd")

# ................... Export Shared Variables ..................
export (String, FILE, "*.tscn") var column_header_path = "res://addons/godot_table/Column/ColumnHeader.tscn"
export (String, FILE, "*.tscn") var data_template_path = "res://addons/godot_table/Data/Data.tscn"
export (Array, String) var column_headers setget _set_column_headers
export (int) var min_row_count setget set_min_row_count
export(Array, Array, String) var rows setget set_rows

# Scenes and Reosurces ......................
var preload_tableContainer : PackedScene = preload("TableContainer.tscn")

# Shared Variables .........................
var tableContainer : TableContainer

var valid_row_count = 0

func _init():
	_init_tree()

# Called when the node enters the scene tree for the first time.
func _ready():
	for cd in tableContainer.headerContainer.get_children():
		if cd.get_class() == "ColumnHeader":
			cd.connect("COLUMN_SORT", self, "_sort_by_column")
	tableContainer.connect("CLICK_ROW", self, "_on_RowButtonContainer_CLICK_ROW")
	
func _init_tree():
	tableContainer = preload_tableContainer.instance()
	self.add_child(tableContainer, true)
	
	tableContainer.init_tree()
	tableContainer.set_template_path(column_header_path, data_template_path)
	
func _set_column_headers(new_header):
	if column_header_path == "":
		return
	column_headers = new_header
	tableContainer.set_header(column_headers)

func set_rows(new_rows):
	valid_row_count = new_rows.size()
	for row in new_rows:
		var row_columns = row.size()
		var header_columns = column_headers.size()
		if row_columns > header_columns:
			push_error("error")
		elif row_columns < header_columns:
			for index in range(header_columns - row_columns):
				row.push_back("--")
	rows = new_rows
	check_add_min_row_count()
	
	tableContainer.set_rows(rows, column_headers.size(), valid_row_count)

func set_min_row_count(count):
	min_row_count = count
	
	if check_add_min_row_count():
		tableContainer.set_rows(rows, column_headers.size(), valid_row_count)
	
func check_add_min_row_count():
	if min_row_count < rows.size(): 
		return false
	else:
		for i in range(min_row_count - rows.size()):
			var row = []
			for j in range(column_headers.size()):
				row.push_back("--")
			rows.push_back(row)
		return true
		
func _on_RowButtonContainer_CLICK_ROW(value):
	emit_signal("CLICK_ROW", value)
