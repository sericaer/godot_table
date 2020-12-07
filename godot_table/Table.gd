tool
extends PanelContainer

# ................... Export Shared Variables ..................
export (String, FILE, "*.tscn") var column_header_path = "res://addons/godot_table/Column/ColumnHeader.tscn"
export (String, FILE, "*.tscn") var data_template_path = "res://addons/godot_table/Data/Data.tscn"
export (Array, String) var column_headers setget _set_column_headers

export(Array, Array, String) var rows setget set_rows

# Scenes and Reosurces ......................
var preload_tableContainer : PackedScene = preload("TableContainer.tscn")

# Shared Variables .........................
var tableContainer : VBoxContainer
var headerContainer : HeaderContainer
var dataContainer : DataContainer

func _init():
	_init_tree()

# Called when the node enters the scene tree for the first time.
func _ready():
	for cd in headerContainer.get_children():
		if cd.get_class() == "ColumnHeader":
			cd.connect("COLUMN_SORT", self, "_sort_by_column")

func _init_tree():
	tableContainer = preload_tableContainer.instance()
	self.add_child(tableContainer, true)
	
	headerContainer = tableContainer.get_node("HBoxContainer/HeaderContainer")
	dataContainer = tableContainer.get_node("ScrollContainer/DataContainer")
	
	headerContainer.column_header_path = column_header_path
	dataContainer.template_path = data_template_path
	
func _set_column_headers(new_header):
	if column_header_path == "":
		return
	column_headers = new_header
	headerContainer.clear_headers()
	headerContainer.add_headers(column_headers)

func set_rows(new_rows):
	rows = new_rows
	for row in new_rows:
		var row_columns = row.size()
		var header_columns = column_headers.size()
		if row_columns > header_columns:
			push_error("error")
		elif row_columns < header_columns:
			for index in range(header_columns - row_columns):
				row.push_back("--")
	dataContainer.clear_rows()
	dataContainer.set_rows(new_rows, column_headers.size());
