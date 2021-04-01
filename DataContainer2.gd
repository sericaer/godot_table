tool

extends PanelContainer

func show_rows(table_data, template_path):
	var labels : Array = table_data.get_lables(template_path) 
	$DataContainer.show_rows(labels)
	$RowButtonContainer.set_rows(table_data.get_buttons())

func set_column_size(size):
	$DataContainer.columns = size
