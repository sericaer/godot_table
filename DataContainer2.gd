tool

extends PanelContainer

const RowButtonContainer = preload("res://addons/godot_table/RowButtonContainer.gd")
const TableData = preload("TableData.gd")

var rowButtonContainer : RowButtonContainer

func _ready():
	rowButtonContainer = $RowButtonContainer
	
func show_rows(table_data, template_path):
	var labels : Array = table_data.get_lables(template_path) 
	print("labels.size", labels.size())
	$DataContainer.show_rows(labels)
#	rowButtonContainer.set_rows(table_data.get_buttons())
func set_column_size(size):
	$DataContainer.columns = size
