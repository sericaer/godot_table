tool

extends Node

var _labels : Array
var _button : Button
var _template : String
var _string_datas : Array

func get_data():
	return _string_datas
	
func set_data(var string_datas : Array):
	_string_datas  =  string_datas
	return self
	
func set_min_size(var size : int):
	for i in range(_string_datas.size(), size):
		_string_datas.append("--")
	return self

#func set_data(var string_datas : Array):
#	for string_data in string_datas:
#		var label = Label.new()
#		label.text = string_data
#		_labels.append(label)
#	_button = Button.new()
#	if _labels.size() == 0:
#		_button.disabled = true
#	return self
#
#func set_min_size(var size : int):
#	print("set_min_size", size, " ", _labels.size())
#	for i in range(_labels.size(), size):
#		var label = Label.new()
#		label.text = "--"
#		_labels.append(label)
#	return self

func get_lables(var template : String):
	return _labels

func get_button():
	return _button
	
