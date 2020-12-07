tool

extends VBoxContainer

var v_scrollbar : VScrollBar
var headerPanelPlus : Panel
var headerContainer : HeaderContainer
var dataContainer : DataContainer

var cmp = MyCustomSorter.new()

func _on_vscrollbar_visibility_changed():
	if v_scrollbar.visible == true:
		headerPanelPlus.rect_min_size.x = v_scrollbar.rect_size.x
	else:
		headerPanelPlus.rect_min_size.x = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	v_scrollbar = self.get_node("ScrollContainer").get_v_scrollbar()
	headerPanelPlus = self.get_node("HBoxContainer/PanelPlus")
	headerContainer = self.get_node("HBoxContainer/HeaderContainer")
	dataContainer = self.get_node("ScrollContainer/DataContainer")

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
