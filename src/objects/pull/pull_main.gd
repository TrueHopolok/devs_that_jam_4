extends Control

signal finished(name: String)
signal failed

@export var game_length: float = 50.0

@onready var success_bar: ProgressBar = %SuccessBar
@onready var time_progressbar: ProgressBar = %TimeBar
@onready var game_timer: Timer = %GameTimer
@onready var catch_area: Area2D = %CatchArea
@onready var fish_area: Area2D = %FishArea
@onready var animation_timer: Timer = %AnimationTimer
@onready var player: AnimatedSprite2D = get_tree().get_first_node_in_group("PlayerAnimation")


func _ready() -> void:
	set_process(false)
	set_process_input(false)
	visible = false


func _process(delta: float) -> void:
	time_progressbar.value = game_timer.time_left / game_length


func _on_game_timer_timeout() -> void:
	set_process(false)
	set_process_input(false)
	visible = false
	# TODO: play_sound(error)
	player.play("fail")
	await player.animation_finished
	animation_timer.start(1.0)
	await animation_timer.timeout
	failed.emit()


func _on_success_bar_value_changed(value: float) -> void:
	if value == success_bar.max_value:
		game_timer.stop()
		catch_area.deactivate()
		fish_area.deactivate()
		set_process(false)
		set_process_input(false)
		visible = false
		# TODO: play_sound(success)
		player.play("success")
		await player.animation_finished
		animation_timer.start(1.0)
		await animation_timer.timeout
		finished.emit(NameGenerator.next())


func activate() -> void:
	player.play("pulling")
	# TODO: play_sound(process)
	catch_area.activate()
	fish_area.activate()
	game_timer.start(game_length)
	set_process(true)
	set_process_input(true)
	visible = true
