extends Node2D

const SAVE_FILE_PATH: String = "user://stats.yours"
const MIN_FISHES: int = 5

enum STATE {
	InMenu,
	Throwing,
	Catching,
	Pulling,
	Swimming,
}

@onready var hotbar: CanvasLayer = $Hotbar
@onready var objects: Dictionary = {
	"menu": 	%MenuUI,
	"throw": 	%Throw,
	"catch": 	%Catch,
	"pull": 	%Pull,
	"swim": 	%Swim,
}

var fishes_left: int = 10
var game_state: STATE = STATE.InMenu
var stats: Dictionary = {
	"time": 0,
	"lost": 0,
	"catched": 0,
}


func _ready() -> void:
	load_stats()
	connect_objects()
	activate_object()


# Activate ceratain object based on game state
func activate_object(new_state: STATE = game_state) -> void:
	game_state = new_state
	match game_state:
		STATE.InMenu:
			objects["menu"].activate()
		STATE.Swimming:
			objects["swim"].activate()
		STATE.Throwing:
			objects["throw"].activate()
		STATE.Catching:
			objects["catch"].activate()
		STATE.Pulling:
			objects["pull"].activate()
		_:
			assert(false, "Incorrect state/object activation")


# Connect functions to finished signals in objects
func connect_objects() -> void:
	objects["menu"].finished.connect(activate_object.bind(STATE.Throwing))
	objects["swim"].finished.connect(func() -> void:
		randomize()
		fishes_left = randi_range(MIN_FISHES, MIN_FISHES * 2)
		activate_object.bind(STATE.Throwing))
	objects["throw"].finished.connect(activate_object.bind(STATE.Catching))
	objects["catch"].failed.connect(func() -> void:
		stats["lost"] += 1
		save_stats())
	objects["catch"].finished.connect(activate_object.bind(STATE.Pulling))
	objects["pull"].failed.connect(func() -> void:
		stats["lost"] += 1
		save_stats()
		activate_object(STATE.Throwing))
	objects["pull"].finished.connect(func(name: String) -> void:
		stats["catched"] += 1
		save_stats()
		hotbar.display(name)
		fishes_left -= 1
		if fishes_left <= 0:
			activate_object(STATE.Swimming)
		else:
			activate_object(STATE.Throwing))


func load_stats() -> void:
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		return
	var file := FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	var raw_data := file.get_as_text()
	file.close()
	stats = JSON.parse_string(raw_data)


func save_stats() -> void:
	var raw_data := JSON.stringify(stats, "\t")
	var file := FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_string(raw_data)
	file.close()
