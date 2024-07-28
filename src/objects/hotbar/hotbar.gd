extends CanvasLayer

const TEXT: String = "You caught: {catched}"

@onready var label: Label = $MarginContainer/Label
@onready var timer: Timer = $Timer

func _ready() -> void:
	label.visible = false


func display(name: String) -> void:
	label.visible = true	
	label.text = TEXT.format({"catched": name})
	timer.start(10)


func _on_timer_timeout() -> void:
	label.visible = false
