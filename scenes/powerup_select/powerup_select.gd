extends Control

signal powerup_selected(powerup_variant)

const PowerupCard := preload("powerup_card.gd")
# gdlint: ignore=constant-name
const PowerupCardProps := PowerupCard.PowerupCardProps

# gdlint: ignore=class-variable-name
var PowerupVariant = PowerupDatabase.PowerupVariant

onready var _cards_container := get_node("%CardsContainer") as HBoxContainer
onready var _player := find_parent("Player") as Player


func _ready():
	assert(_cards_container != null)
	assert(_player != null)


func _process(_delta):
	if OS.is_debug_build() and Input.is_action_just_pressed("debug_powerup"):
		var cards_props := [
			PowerupDatabase.PowerupVariant.TEST1,
			PowerupDatabase.PowerupVariant.TEST2,
		]

		show_cards(cards_props)


# cards_props has to be array of PowerupCardProps or CardVariant
func show_cards(cards: Array):
	_delete_all_cards()

	for card in cards:
		if card is PowerupCardProps:
			_add_card(card)
		else:
			_add_card_by_variant(card)

	_show()


func _show():
	visible = true
	get_tree().paused = true


func _hide():
	visible = false
	get_tree().paused = false


# variant: CardVariant
func _add_card_by_variant(variant: int):
	assert(variant < PowerupDatabase.PowerupVariant.size())
	assert(variant >= 0)
	_add_card(PowerupDatabase.variant_to_props[variant])


func _add_card(props: PowerupCardProps):
	assert(props.name != null)
	assert(props.texture != null)
	assert(props.description != null)
	assert(props.variant != null)

	var card = _create_card(props)

	card.connect("selected", self, "_on_card_selected")
	_cards_container.add_child(card)


func _delete_all_cards():
	for _card in _cards_container.get_children():
		var card := _card as Node
		card.queue_free()


static func _create_card(card_props: PowerupCardProps) -> PowerupCard:
	var card := preload("powerup_card.tscn").instance() as PowerupCard

	card.props = card_props

	return card


func _on_card_selected(variant: int):
	_hide()
	emit_signal("powerup_selected", variant)
