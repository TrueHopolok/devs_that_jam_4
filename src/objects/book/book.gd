extends Control

@onready var main = get_tree().get_first_node_in_group("Main")
@onready var stats: Label = %StatsLabel
@onready var book: VBoxContainer = %StatsContainer

const FISH_CAUGHT: String = "
Time played: {time}
Fishes catched: {catched}
Fishes lost: {lost}"

func _ready() -> void:
	book.visible = false


func _on_button_pressed() -> void:
	stats.text = FISH_CAUGHT.format({
		"time": main.stats["time"], 
		"catched": main.stats["catched"], 
		"lost": main.stats["lost"]})
	book.visible = !book.visible
	get_tree().paused = book.visible
