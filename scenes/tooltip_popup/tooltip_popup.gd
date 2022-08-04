tool
extends Node2D

export var bbcode_text := "" setget set_bbcode_text

var _last_bbcode_text := ""

onready var _label := get_node("PanelContainer/RichTextLabel") as RichTextLabel


func _ready():
	assert(_label != null)
	_set_label_text()


func hide_popup():
	hide()


func show_popup():
	show()


func set_bbcode_text(text: String):
	bbcode_text = text
	if _label != null:
		_set_label_text()


func _set_label_text():
	_label.bbcode_text = str("[center]", bbcode_text, "[/center]")
