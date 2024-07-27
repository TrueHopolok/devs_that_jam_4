extends Node2D

enum STATE {
	InMenu,
	Waiting,
	Throwing,
	Catching,
	Pulling,
	Swimming,
}

@export var game_state: STATE = STATE.InMenu

# TODO: add all new objects into dict
var objects: Dictionary = {
	"menu": 	null,
	"throw": 	null,
	"catch": 	null,
	"pull": 	null,
	"swim": 	null,
}


func _ready() -> void:
	connect_objects()
	activate_object()


# TODO: for all new object add activation
# Activate ceratain object based on game state
func activate_object() -> void:
	match game_state:
		STATE.InMenu:
			#objects["menu"].activate()
			pass
		_:
			assert(false, "Incorrect state/object ot activate")


# TODO: for all new objects add connection
# Connect functions to finished signals in objects
func connect_objects() -> void:
	#objects["menu"].finished.connect(finish_menu)
	pass
