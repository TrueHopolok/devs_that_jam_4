extends ProgressBar

signal finished

@export_range(1, 50) var needed_success_amount: int = 5
@export_range(0.0, 0.5) var timing_error: float = 0.05
#@onready var player: AnimationPlayer = get_tree().get_first_node_in_group("PlayerAnimation")
@onready var background: Node2D = get_tree().get_first_node_in_group("Background")

var current_success_amount: int = 0

func _ready() -> void:
	set_process(false)
	set_process_input(false)
	visible = false


func _process(delta: float) -> void:
	value += delta
	if value > max_value + timing_error:
		# TODO: play_sound(error)
		value = 0.0


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		if value >= max_value - timing_error and value <= max_value + timing_error:
			current_success_amount += 1
			background.move()
			# TODO: 
			# play_sound(success) IN PLAYER
			# play_animation(swim) IN PLAYER
			if current_success_amount >= needed_success_amount:
				set_process(false)
				set_process_input(false)
				# TODO: wait for animation to finished
				finished.emit()
				visible = false
		else:
			# TODO: play_sound(error)
			pass
		value = 0.0


func activate() -> void:
	value = 0.0
	current_success_amount = 0
	set_process(true)
	set_process_input(true)
	visible = true
