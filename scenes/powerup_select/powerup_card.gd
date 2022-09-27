extends ColorRect

signal selected(variant)

var props: PowerupCardProps

onready var _name_node := get_node("%Name") as RichTextLabel
onready var _image_node := get_node("%Image") as TextureRect
onready var _description_node := get_node("%Description") as RichTextLabel


class PowerupCardProps:
	var name: String
	var description: String
	var texture: Texture
	var variant: int

	func _init(_name: String, _description: String, _texture: Texture, _variant: int):
		name = _name
		description = _description
		texture = _texture
		variant = _variant


func _ready():
	assert(_name_node != null)
	assert(_image_node != null)
	assert(_description_node != null)
	assert(props != null)

	_name_node.bbcode_text = str("[center]", props.name, "[/center]")
	_image_node.texture = props.texture
	_description_node.bbcode_text = str("[center]", props.description, "[/center]")


func _on_SelectButton_pressed():
	emit_signal("selected", props.variant)
