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
	for i in min(_datas.size(), string_data.size()):
		_datas[i].set_data(string_data[i]).set_min_size(_column_size)
	for i in range(_datas.size(), string_data.size()):
		_datas.append(RowData.new().set_data(string_data[i]).set_min_size(_column_size))
	var need_removes = []
	for i in range(string_data.size(), _datas.size()):
		need_removes.push_back(_datas[i])
	for elem in need_removes:
		_datas.erase(elem)
		elem.clear()
		elem.queue_free()
	return self

func set_row_data(var new_row_data: Array):
	for elem in _datas:
		_datas.erase(elem)
		elem.clear()
		elem.queue_free()
	_datas = new_row_data
	return self
	
func get_lables(var template : String):
	var rslt = []
	for i in _datas.size():
		var row = _datas[i]
		rslt.append(row.get_lables(template, i))
	return rslt

func get_buttons():
	var rslt = []
	for row in _datas:
		rslt.append(row.get_button())
	return rslt

func set_data_template_path(path):
	_data_template_path = path

func get_row_data():
	return _datas
