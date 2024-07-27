extends HBoxContainer

signal finished
signal failed

@export var game_length: float = 50.0

@onready var success_bar: ProgressBar = %SuccessBar
@onready var time_progressbar: ProgressBar = %TimeBar
@onready var game_timer: Timer = %GameTimer
@onready var catch_area: Area2D = %CatchArea
@onready var fish_area: Area2D = %FishArea

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
		catch_area.deactivate()
		fish_area.deactivate()
		set_process(false)
		set_process_input(false)
		# TODO:
		# play_sound(success)
		# play_animation(success)
		# wait till animation is finished
		finished.emit()
		visible = false


func activate():
	catch_area.activate()
	fish_area.activate()
	game_timer.start(game_length)
	set_process(true)
	set_process_input(true)
	visible = true
