@tool

extends VBoxContainer

const HeaderContainer = preload("res://addons/godot_table/HeaderContainer.gd")
const DataContainer = preload("res://addons/godot_table/DataContainer.gd")
const RowButtonContainer = preload("res://addons/godot_table/RowButtonContainer.gd")

signal CLICK_ROW(value)

var v_scrollbar : VScrollBar
var headerPanelPlus : Panel
var headerContainer : HeaderContainer
var dataContainer : DataContainer
var rowButtonContainer : RowButtonContainer

var cmp = MyCustomSorter.new()


func _on_vscrollbar_visibility_changed():
	if v_scrollbar.visible == true:
		headerPanelPlus.custom_minimum_size.x = v_scrollbar.size.x
	else:
		headerPanelPlus.custom_minimum_size.x = 0
		
func init_tree():
	headerPanelPlus = $HBoxContainer/PanelPlus
	headerContainer = $HBoxContainer/HeaderContainer
	dataContainer = $ScrollContainer/PanelContainer/DataContainer
	rowButtonContainer = $ScrollContainer/PanelContainer/RowButtonContainer
	
# Called when the node enters the scene tree for the first time.
func _ready():
	v_scrollbar = self.get_node("ScrollContainer").get_v_scroll_bar()
	v_scrollbar.connect("visibility_changed",Callable(self,"_on_vscrollbar_visibility_changed"))
	if headerContainer:
		for header in headerContainer.get_children():
			header.connect("COLUMN_SORT",Callable(self,"_sort_by_column"))
	
func _sort_by_column(select_column):
	for column in headerContainer.get_children():
		if column != select_column:
			column._SortStateNULL()

	cmp.sort_index = select_column.index
	cmp.sort_state = select_column.sortState

	dataContainer.sort_column(cmp)

func set_template_path(column_header_path, data_template_path) -> void:
	headerContainer.column_header_path = column_header_path
	dataContainer.template_path = data_template_path

func set_header(column_headers, color_background:Color):
	headerContainer.clear_headers()
	$ScrollContainer/PanelContainer.get_theme_stylebox("panel").bg_color = color_background
	headerContainer.add_headers(column_headers)

func set_rows(new_rows:Array, column_size, valid_row_count):
	dataContainer.clear_rows()
	dataContainer.set_rows(new_rows, column_size)
	rowButtonContainer.set_rows(new_rows.size())
	for i in range(rowButtonContainer.get_children().size()):
		var rowButton = rowButtonContainer.get_child(i) as Button
		if i<valid_row_count :
			rowButton.connect("pressed",Callable(self,"_on_RowButtonContainer_CLICK_ROW").bind(int(str(rowButton.name))))
		else:
			rowButton.disabled  = true
	
class MyCustomSorter:
	var sort_index = -1
	var sort_state = -1

	func sort(a, b):
		if sort_state == 1:
			return sort_ascending(a, b)
		if sort_state == 0:
			return sort_descending(a, b)

	func sort_ascending(a, b):
		if a[sort_index] == '--':
			return false
		if a[sort_index] < b[sort_index]:
			return true
		return false

	func sort_descending(a, b):
		if a[sort_index] == '--':
			return false
		if a[sort_index] > b[sort_index]:
			return true
		return false

func set_header_style(header_normal:StyleBoxFlat, header_hover:StyleBoxFlat, header_pressed:StyleBoxFlat) -> void:
	headerContainer.set_style(header_normal, header_hover, header_pressed)

func set_header_font(main_font:Font, font_size:int) -> void:
	headerContainer.set_font(main_font, font_size)

func set_row_font(main_font:Font, font_size:int) -> void:
	dataContainer.set_font(main_font, font_size)

func set_btn_style(row_one_normal:StyleBoxFlat, row_two_normal:StyleBoxFlat, btn_hover:StyleBoxFlat, btn_pressed:StyleBoxFlat) -> void:
	rowButtonContainer.set_style(row_one_normal, row_two_normal, btn_hover, btn_pressed)


func _on_RowButtonContainer_CLICK_ROW(index):
	emit_signal("CLICK_ROW", dataContainer.get_row_data(index))
