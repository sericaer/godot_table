tool

extends PanelContainer

const DataContainer = preload("res://addons/godot_table/DataContainer.gd")
const RowButtonContainer = preload("res://addons/godot_table/RowButtonContainer.gd")
const TableData = preload("TableData.gd")

var dataContainer : DataContainer
var rowButtonContainer : RowButtonContainer
var template_path:String

func _ready():
	dataContainer = $DataContainer
	rowButtonContainer = $RowButtonContainer
	
func show_rows(table_data):
	dataContainer.show_rows(table_data.get_lables(template_path))
#	rowButtonContainer.set_rows(table_data.get_buttons())
func set_column_size(size):
	dataContainer.columns = size
