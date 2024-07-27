extends CanvasLayer

const text: String = "You caught: {catched}"
@onready var label = $MarginContainer/Label

func display(name: String) -> void:
	label.text = text.format({"catched": name})
