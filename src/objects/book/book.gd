extends CanvasLayer

@onready var main = get_tree().get_first_node_in_group("Main")
@onready var stats = %StatsLabel
@onready var book = %StatsContainer
var fish_catched_t = "
Time played: {time}
Fishes catched: {catched}
Fishes lost: {lost}"

func _ready():
	book.visible = false


func _on_button_pressed():
	stats.text = fish_catched_t.format({
		"time": main.stats["time"], 
		"catched": main.stats["catched"], 
		"lost": main.stats["lost"]})
	book.visible = !book.visible
	get_tree().paused = book.visible
