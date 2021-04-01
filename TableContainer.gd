tool

extends VBoxContainer

const HeaderContainer = preload("res://addons/godot_table/HeaderContainer.gd")
const DataContainer2 = preload("res://addons/godot_table/DataContainer2.gd")
#
#signal CLICK_ROW(value)
#
var v_scrollbar : VScrollBar
var headerPanelPlus : Panel
var headerContainer : HeaderContainer
var dataContainer2 : DataContainer2
#
#var cmp = MyCustomSorter.new()
#
#func _on_vscrollbar_visibility_changed():
#	if v_scrollbar.visible == true:
#		headerPanelPlus.rect_min_size.x = v_scrollbar.rect_size.x
#	else:
#		headerPanelPlus.rect_min_size.x = 0
#

func _ready():
	headerPanelPlus = $HBoxContainer/PanelPlus
	headerContainer = $HBoxContainer/HeaderContainer
	dataContainer2 = $ScrollContainer/PanelContainer
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	v_scrollbar = self.get_node("ScrollContainer").get_v_scrollbar()
#	v_scrollbar.connect("visibility_changed", self, "_on_vscrollbar_visibility_changed")
#	for header in headerContainer.get_children():
#		header.connect("COLUMN_SORT", self, "_sort_by_column")
#
#func _sort_by_column(select_column):
#	for column in headerContainer.get_children():
#		if column != select_column:
#			column._SortStateNULL()
#	cmp.sort_index = select_column.index
#	cmp.sort_state = select_column.sortState
#	#dataContainer2.sort_column(cmp)
#

func set_data_template_path(path):
	$ScrollContainer/PanelContainer.template_path = path
#
func show_header(column_headers, template_path):
	$HBoxContainer/HeaderContainer.update_headers(column_headers, template_path)
#	$ScrollContainer/PanelContainer.set_column_size(column_headers.size())

func show_data(table_data):
	$ScrollContainer/PanelContainer.show_rows(table_data)
	pass
	
#func show_rows(new_rows : Array):
#	dataContainer2.clear_rows()
#	dataContainer2.show_rows(new_rows);
#
#class MyCustomSorter:
#	var sort_index = -1
#	var sort_state = -1
#
#	func sort(a, b):
#		if sort_state == 1:
#			return sort_ascending(a, b)
#		if sort_state == 0:
#			return sort_descending(a, b)
#
#	func sort_ascending(a, b):
#		if a[sort_index] == '--':
#			return false
#		if a[sort_index] < b[sort_index]:
#			return true
#		return false
#
#	func sort_descending(a, b):
#		if a[sort_index] == '--':
#			return false
#		if a[sort_index] > b[sort_index]:
#			return true
#		return false
#
#
#func _on_RowButtonContainer_CLICK_ROW(index):
#	#emit_signal("CLICK_ROW", dataContainer.get_row_data(index))
#	pass
