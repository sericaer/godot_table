tool

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
		headerPanelPlus.rect_min_size.x = v_scrollbar.rect_size.x
	else:
		headerPanelPlus.rect_min_size.x = 0
		
func init_tree():
	headerPanelPlus = self.get_node("HBoxContainer/PanelPlus")
	headerContainer = self.get_node("HBoxContainer/HeaderContainer")
	dataContainer = self.get_node("ScrollContainer/PanelContainer/DataContainer")
	rowButtonContainer = self.get_node("ScrollContainer/PanelContainer/RowButtonContainer")
	
# Called when the node enters the scene tree for the first time.
func _ready():
	v_scrollbar = self.get_node("ScrollContainer").get_v_scrollbar()
	v_scrollbar.connect("visibility_changed", self, "_on_vscrollbar_visibility_changed")
	for header in headerContainer.get_children():
		header.connect("COLUMN_SORT", self, "_sort_by_column")
	
func _sort_by_column(select_column):
	for column in headerContainer.get_children():
		if column != select_column:
			column._SortStateNULL()

	cmp.sort_index = select_column.index
	cmp.sort_state = select_column.sortState

	dataContainer.sort_column(cmp)

func set_template_path(column_header_path, data_template_path):
	print(headerContainer)
	headerContainer.column_header_path = column_header_path
	dataContainer.template_path = data_template_path

func set_header(column_headers):
	headerContainer.clear_headers()
	headerContainer.add_headers(column_headers)

func set_rows(new_rows : Array, column_size, valid_row_count):
	dataContainer.clear_rows()
	dataContainer.set_rows(new_rows, column_size);
	rowButtonContainer.set_rows(new_rows.size());
	for i in range(rowButtonContainer.get_children().size()):
		var rowButton = rowButtonContainer.get_child(i) as Button
		if i<valid_row_count :
			rowButton.connect("pressed", self, "_on_RowButtonContainer_CLICK_ROW", [int(rowButton.name)])
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


func _on_RowButtonContainer_CLICK_ROW(index):
	emit_signal("CLICK_ROW", dataContainer.get_row_data(index))
