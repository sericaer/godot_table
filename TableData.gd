tool

extends Node

const RowData = preload("RowData.gd")

var _datas : Array
var _column_size : int
var _data_template_path : String

func get_string_data():
	var rslt = []
	for row in _datas:
		rslt.append(row.get_data())
	return rslt

func get_column_size():
	return _column_size
	
func set_column_size(var column_size):
	_column_size = column_size
	for row in _datas:
		row.set_min_size(_column_size)
	return self
	
func set_string_data(var string_data):
	for row in _datas:
		row.queue_free()
	_datas.clear()
	for string_row in string_data:
		_datas.append(RowData.new().set_data(string_row).set_min_size(_column_size))
	return self
	
func get_lables(var template : String):
	var rslt = []
	for row in _datas:
		rslt.append(row.get_lables(template))
	return rslt

func get_buttons():
	var rslt = []
	for row in _datas:
		rslt.append(row.get_button())
	return rslt

func set_data_template_path(path):
	_data_template_path = path
