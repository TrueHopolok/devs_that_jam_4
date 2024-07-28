extends TextureProgressBar

signal finished

@export_range(1, 50) var needed_success_amount: int = 5
@export_range(0.0, 0.5) var timing_error: float = 0.1
@onready var background: Node2D = get_tree().get_first_node_in_group("Background")
@onready var player: AnimatedSprite2D = get_tree().get_first_node_in_group("PlayerAnimation")
@onready var appear: AnimationPlayer = $AnimationPlayer

var current_success_amount: int = 0

func _ready() -> void:
	set_process(false)
	set_process_input(false)


func _process(delta: float) -> void:
	value += delta
	if value > max_value + timing_error:
		value = 0.0


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		if value >= max_value - timing_error and value <= max_value + timing_error:
			current_success_amount += 1
			background.move()
			# TODO: play_sound(success) IN PLAYER
			player.play("swimming")
			if current_success_amount >= needed_success_amount:
				set_process(false)
				set_process_input(false)
				await player.animation_finished
				appear.play("disappear")
				await appear.animation_finished
				finished.emit()
				visible = false
		value = 0.0


func activate() -> void:
	player.play("swimming")
	player.stop()
	value = 0.0
	current_success_amount = 0
	appear.play("appear")
	await appear.animation_finished
	set_process_input(true)
	set_process(true)
