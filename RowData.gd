tool

extends Node

var _labels : Array
var _button : Button
var _template : String
var _string_datas : Array
var _disable : bool

func get_data():
	return _string_datas
	
func set_data(var string_datas : Array):
	_string_datas  =  string_datas
	if _button == null:
		_button = Button.new()
		_disable = false
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

func get_lables(var template_path : String, var colum_id : int):
	for i in range(_labels.size(), _string_datas.size()):
		var new_label = load(template_path).instance()
		new_label.name = "DATA_%d_%d"%[i, colum_id]
		_labels.push_back(new_label)
		print("add label[", new_label.name,"]")
	for i in _string_datas.size():
		_labels[i].text = _string_datas[i]
	_button.rect_min_size = _labels[0].rect_min_size - Vector2(0,1)
	return _labels

func get_button():
	_button.disabled = _disable
	print("_button.disabled", _button.disabled)
	return _button

func set_disable(var flag : bool):
	_disable = flag
	if _button != null:
		_button.disabled = _disable
	return self
	
func clear():
	for label in _labels:
		label.queue_free()
	print("_button.queue_free()", _button)
	_button.queue_free()
	
