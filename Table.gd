#TODO live update in the editor
@tool

extends PanelContainer

signal CLICK_ROW(value)

const TableContainer = preload("res://addons/godot_table/TableContainer.gd")

# ................... Export Shared Variables ..................
@export_group("Header")
@export var header_normal:StyleBoxFlat = StyleBoxFlat.new() : set = _initialize_header_normal
@export var header_hover:StyleBoxFlat = StyleBoxFlat.new() : set = _initialize_header_hover
@export var header_pressed:StyleBoxFlat = StyleBoxFlat.new() : set = _initialize_header_pressed
@export_group("Table")
@export var row_one_normal:StyleBoxFlat = StyleBoxFlat.new() : set = _initialize_row_one_normal
@export var row_two_normal:StyleBoxFlat = StyleBoxFlat.new() : set = _initialize_row_two_normal
@export var row_hover:StyleBoxFlat = StyleBoxFlat.new() : set = _initialize_row_hover
@export var row_pressed:StyleBoxFlat = StyleBoxFlat.new() : set = _initialize_row_pressed
@export var color_background:Color = Color(0.11, 0.11, 0.11)
@export_group("Font")
@export var main_font:Font = SystemFont.new()
@export var font_size_header:int = 16
@export var font_size_table:int = 16
@export_group("Internal")
@export var column_header_path = "res://addons/godot_table/Column/ColumnHeader.tscn"
@export var data_template_path = "res://addons/godot_table/Data/Data.tscn"
@export_group("")
@export var column_headers:Array[String] : set = _set_column_headers
@export var min_row_count:int : set = set_min_row_count
@export var rows:Array[Array] : set = set_rows

# Scenes and Resources ......................
var preload_tableContainer : PackedScene = preload("res://addons/godot_table/TableContainer.tscn")

# Shared Variables .........................
var tableContainer : TableContainer

var valid_row_count = 0

func _init():
	_init_tree()

# Called when the node enters the scene tree for the first time.
func _ready():
	for cd in tableContainer.headerContainer.get_children():
		if cd.get_class() == "ColumnHeader":
			cd.connect("COLUMN_SORT",Callable(self,"_sort_by_column"))
	tableContainer.connect("CLICK_ROW",Callable(self,"_on_RowButtonContainer_CLICK_ROW"))

func _init_tree():
	tableContainer = preload_tableContainer.instantiate()
	self.add_child(tableContainer, true)
	
	tableContainer.init_tree()
	tableContainer.set_template_path(column_header_path, data_template_path)

func _set_column_headers(new_header):
	if column_header_path == "":
		return
	column_headers = new_header
	tableContainer.set_header_style(header_normal, header_hover, header_pressed)
	tableContainer.set_header_font(main_font, font_size_header)
	tableContainer.set_header(column_headers, color_background)

	for row in rows:
		var row_columns = row.size()
		var header_columns = column_headers.size()
		if row_columns > header_columns:
			row.resize(header_columns)
		elif row_columns < header_columns:
			for index in range(header_columns - row_columns):
				row.push_back("--")
		valid_row_count = rows.size()
	tableContainer.set_row_font(main_font, font_size_table)
	tableContainer.set_btn_style(row_one_normal, row_two_normal, row_hover, row_pressed)
	tableContainer.set_rows(rows, column_headers.size(), valid_row_count)

func set_rows(new_rows):
	valid_row_count = new_rows.size()
	for row in new_rows:
		var row_columns = row.size()
		var header_columns = column_headers.size()
		if row_columns > header_columns:
			row.resize(header_columns)
		elif row_columns < header_columns:
			for index in range(header_columns - row_columns):
				row.push_back("--")
	rows = new_rows
	check_add_min_row_count()
	
	tableContainer.set_row_font(main_font, font_size_table)
	tableContainer.set_btn_style(row_one_normal, row_two_normal, row_hover, row_pressed)
	tableContainer.set_rows(rows, column_headers.size(), valid_row_count)

func set_min_row_count(count):
	min_row_count = count
	
	if check_add_min_row_count():
		tableContainer.set_row_font(main_font, font_size_table)
		tableContainer.set_btn_style(row_one_normal, row_two_normal, row_hover, row_pressed)
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


func _initialize_header_normal(value:StyleBoxFlat):
	if value:
		header_normal = value
	else:
		var style_box = StyleBoxFlat.new()
		style_box.bg_color = Color(0.176, 0.176, 0.176)
		style_box.set_border_width_all(1)
		style_box.border_color = Color(0.8, 0.8, 0.8)
		header_normal  = style_box

func _initialize_header_hover(value:StyleBoxFlat):
	if value:
		header_hover = value
	else:
		var style_box = StyleBoxFlat.new()
		style_box.bg_color = Color(0.275, 0.275, 0.275)
		style_box.set_border_width_all(1)
		style_box.border_color = Color(0.8, 0.8, 0.8)
		header_hover  = style_box

func _initialize_header_pressed(value:StyleBoxFlat):
	if value:
		header_pressed = value
	else:
		var style_box = StyleBoxFlat.new()
		style_box.bg_color = Color(0.145, 0.184, 0.255)
		header_pressed  = style_box

func _initialize_row_one_normal(value:StyleBoxFlat):
	if value:
		row_one_normal = value
	else:
		var style_box = StyleBoxFlat.new()
		style_box.bg_color = Color(0.11, 0.11, 0.11)
		style_box.set_border_width_all(1)
		style_box.border_color = Color(0.8, 0.8, 0.8)
		row_one_normal  = style_box

func _initialize_row_two_normal(value:StyleBoxFlat):
	if value:
		row_two_normal = value
	else:
		var style_box = StyleBoxFlat.new()
		style_box.bg_color = Color(0.11, 0.11, 0.11)
		style_box.set_border_width_all(1)
		style_box.border_color = Color(0.8, 0.8, 0.8)
		row_two_normal  = style_box

func _initialize_row_hover(value:StyleBoxFlat):
	if value:
		row_hover = value
	else:
		var style_box = StyleBoxFlat.new()
		style_box.bg_color = Color(0.176, 0.176, 0.176)
		row_hover  = style_box

func _initialize_row_pressed(value:StyleBoxFlat):
	if value:
		row_pressed = value
	else:
		var style_box = StyleBoxFlat.new()
		style_box.bg_color = Color.BLACK
		row_pressed  = style_box
