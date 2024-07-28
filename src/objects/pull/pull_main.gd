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
@onready var appear: AnimationPlayer = $AnimationPlayer
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var sounds: Dictionary = {
	"pulling": preload( "res://assets/sounds/others/sound_pulling.mp3" ),
	"fail": preload( "res://assets/sounds/others/sound_pull_error.mp3" ),
	"success": preload( "res://assets/sounds/others/sound_pull_success.mp3" ),
}

func _ready() -> void:
	set_process(false)
	set_process_input(false)


func _process(delta: float) -> void:
	time_progressbar.value = game_timer.time_left / game_length


func _on_game_timer_timeout() -> void:
	set_process(false)
	set_process_input(false)
	appear.play("disappear")
	await appear.animation_finished
	audio.stream = sounds["fail"]
	audio.play()
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
		appear.play("disappear")
		await appear.animation_finished
		audio.stream = sounds["success"]
		audio.play()
		player.play("success")
		await player.animation_finished
		animation_timer.start(1.0)
		await animation_timer.timeout
		finished.emit(NameGenerator.next())


func activate() -> void:
	player.play("pulling")
	audio.stream = sounds["pulling"]
	audio.play()
	catch_area.activate()
	fish_area.activate()
	game_timer.start(game_length)
	set_process(true)
	set_process_input(true)
	appear.play("appear")
