tool

extends PanelContainer

func show_rows(table_data, template_path):
	$DataContainer.show_rows(table_data.get_lables(template_path) )
	$RowButtonContainer.set_rows(table_data.get_buttons())

func set_column_size(size):
	$DataContainer.columns = size
