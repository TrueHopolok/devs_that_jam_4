extends Control

@onready var main = get_tree().get_first_node_in_group("Main")
@onready var stats: Label = %StatsLabel
@onready var book: VBoxContainer = %StatsContainer
@onready var book_open: Sprite2D = $BookOpen
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var sound_open: Dictionary = {
	true: preload( "res://assets/sounds/others/sound_book_open.mp3" ),
	false: preload( "res://assets/sounds/others/sound_book_close.mp3" ),
}
var sound_status: bool = true

const FISH_CAUGHT: String = "
Time played: {time}
Fishes catched: {catched}
Fishes lost: {lost}"

func _ready() -> void:
	book.visible = false
	book_open.visible = false


func _on_button_pressed() -> void:
	audio.stream = sound_open[sound_status]
	audio.play()
	sound_status = not sound_status
	stats.text = FISH_CAUGHT.format({
		"time": main.stats["time"], 
		"catched": main.stats["catched"], 
		"lost": main.stats["lost"]})
	book.visible = !book.visible
	book_open.visible = !book_open.visible
	get_tree().paused = book.visible
