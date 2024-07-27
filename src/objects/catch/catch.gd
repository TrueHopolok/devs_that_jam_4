extends TextureProgressBar

signal finished(succeeded: bool)

@export_range(1.0, 120.0) var min_catch_time: float = 5.0
@export_range(1.0, 120.0) var max_catch_time: float = 60.0
@export_range(0.5, 5.0) var cycle_time: float = 1.2
@export_range(1, 50) var cycles_amount: int = 2
@onready var timer: Timer = $Timer
@onready var arrow: Sprite2D = $Arrow

func _ready() -> void:
	set_process(false)
	set_process_input(false)
	visible = false


func _process(delta: float) -> void:
	arrow.rotation_degrees += max_value / cycle_time * delta
	if arrow.rotation_degrees >= radial_initial_angle + value * 2:
		# TODO: play_sound(error)
		activate()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		var degrees := arrow.rotation_degrees
		while degrees < 0.0:
			degrees += max_value
		if degrees >= radial_initial_angle and degrees <= radial_initial_angle + value:
			set_process(false)
			set_process_input(false)
			# TODO:
			# update score(success) IN MAIN
			# play_sounds(success) IN PLAYER
			# play_animation(success) IN PLAYER
			# wait till animation is finished
			finished.emit()
			visible = false
		else:
			# TODO: play_sound(error)
			activate()


func _on_timer_timeout() -> void:
	randomize()
	radial_initial_angle = randf_range(min_value, max_value)
	arrow.rotation_degrees = radial_initial_angle + value * 2 - max_value * cycles_amount
	set_process(true)
	set_process_input(true)
	visible = true


func activate() -> void:
	set_process(false)
	set_process_input(false)
	visible = false
	randomize()
	timer.start(randf_range(min_catch_time, max(max_catch_time, min_catch_time)))
