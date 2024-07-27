extends Node2D

enum STATE {
	InMenu,
	Throwing,
	Catching,
	Pulling,
	Swimming,
}

var game_state: STATE = STATE.InMenu

# TODO: add all new objects into dict
@onready var objects: Dictionary = {
	"menu": 	%MenuUI,
	"throw": 	%Throw,
	"catch": 	%Catch,
	"pull": 	null,
	"swim": 	%Swim,
}


func _ready() -> void:
	connect_objects()
	activate_object()


# TODO: for all new object add activation
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
		_:
			assert(false, "Incorrect state/object ot activate")


# TODO: for all new objects add connection
# Connect functions to finished signals in objects
func connect_objects() -> void:
	objects["menu"].finished.connect(activate_object.bind(STATE.Catching))
	#objects["swim"].finished.connect(finish_swim)
