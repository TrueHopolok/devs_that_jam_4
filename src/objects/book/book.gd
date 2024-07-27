extends CanvasLayer

@onready var stats = $Book/VBoxContainer/Stats


@onready var book = $Book
var fish_catched_t = "
Fishs catched: {catched}
Grass touched: {grass}
"

# Called when the node enters the scene tree for the first time.
func _ready():
	stats.text = fish_catched_t.format({"catched": "HZ", "grass":"0"})
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	book.visible = !book.visible
