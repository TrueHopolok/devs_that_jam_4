extends HBoxContainer

signal finished
signal failed

@export var game_length: float = 10.0

@onready var success_bar: ProgressBar = %SuccessBar
@onready var time_progressbar: ProgressBar = %TimeBar
@onready var game_timer: Timer = %GameTimer
@onready var catch_area: Area2D = %CatchArea



func _ready() -> void:
	set_process(false)
	set_process_input(false)
	visible = false


func _process(delta: float) -> void:
	time_progressbar.value = game_timer.time_left / game_length


func _on_game_timer_timeout() -> void:
	set_process(false)
	set_process_input(false)
	# TODO: play_sound(error)
	failed.emit()
	visible = false


func _on_success_bar_value_changed(value: float) -> void:
	if value == success_bar.max_value:
		game_timer.stop()
		set_process(false)
		set_process_input(false)
		# TODO:
		# play_sound(success)
		# play_animation(success)
		# wait till animation is finished
		print("You catched: ", NameGenerator.next())
		finished.emit()
		visible = false




func activate():
	catch_area.reset()
	game_timer.start(game_length)
	set_process(true)
	set_process_input(true)
	visible = true
