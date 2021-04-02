tool

extends VBoxContainer

#
#var cmp = MyCustomSorter.new()
#
func _on_vscrollbar_visibility_changed():
	if _scrollbar().visible == true:
		_header_panel_plus().rect_min_size.x = _scrollbar().rect_size.x
	else:
		_header_panel_plus().rect_min_size.x = 0


#func _ready():
#	headerPanelPlus = $HBoxContainer/PanelPlus
#	headerContainer = $HBoxContainer/HeaderContainer
#	dataContainer2 = $ScrollContainer/PanelContainer
#
## Called when the node enters the scene tree for the first time.
func _ready():
	_scrollbar().connect("visibility_changed", self, "_on_vscrollbar_visibility_changed")
#	for header in $HBoxContainer/HeaderContainer.get_children():
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
	_data_container().template_path = path
#
func show_header(column_headers, template_path):
	_header_container().update_headers(column_headers, template_path)
	_data_container().set_column_size(column_headers.size())

func show_data(table_data, data_template_path):
	_data_container().show_rows(table_data, data_template_path)
		
func _scrollbar():
	return $ScrollContainer.get_v_scrollbar()

func _header_panel_plus():
	return $HBoxContainer/PanelPlus
	
func _data_container():
	return $ScrollContainer/PanelContainer

func _header_container():
	return $HBoxContainer/HeaderContainer
		
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
