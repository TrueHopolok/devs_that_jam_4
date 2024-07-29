extends TextureProgressBar

signal finished
signal failed

@export_range(1.0, 120.0) var min_catch_time: float = 5.0
@export_range(1.0, 120.0) var max_catch_time: float = 25.0
@export_range(0.5, 5.0) var cycle_time: float = 1.2
@export_range(1, 50) var cycles_amount: int = 2
@onready var timer: Timer = $Timer
@onready var arrow: Sprite2D = $Arrow
@onready var player: AnimatedSprite2D = get_tree().get_first_node_in_group("PlayerAnimation")
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var sounds: Dictionary = {
	"error": preload( "res://assets/sounds/others/sound_catch_error.mp3" ),
	"warning": preload( "res://assets/sounds/others/sound_catch_warning.mp3" ),
}

func _ready() -> void:
	set_process(false)
	set_process_input(false)
	visible = false


func _process(delta: float) -> void:
	arrow.rotation_degrees += max_value / cycle_time * delta
	if arrow.rotation_degrees >= radial_initial_angle + value * 2:
		audio.stream = sounds["error"]
		audio.play()
		failed.emit()
		activate()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		var degrees := arrow.rotation_degrees
		while degrees < 0.0:
			degrees += max_value
		if degrees >= radial_initial_angle and degrees <= radial_initial_angle + value:
			set_process(false)
			set_process_input(false)
			finished.emit()
			visible = false
		else:
			audio.stream = sounds["error"]
			audio.play()
			failed.emit()
			activate()


func _on_timer_timeout() -> void:
	player.play("catching")
	audio.stream = sounds["warning"]
	audio.play()
	randomize()
	radial_initial_angle = randf_range(min_value, max_value)
	arrow.rotation_degrees = radial_initial_angle + value * 2 - max_value * cycles_amount
	set_process(true)
	set_process_input(true)
	visible = true


func activate() -> void:
	player.play("fishing")
	set_process(false)
	set_process_input(false)
	visible = false
	randomize()
	timer.start(randf_range(min_catch_time, max(max_catch_time, min_catch_time)))
