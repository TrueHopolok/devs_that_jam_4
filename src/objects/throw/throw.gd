extends TextureProgressBar

signal finished

@onready var player: AnimatedSprite2D = get_tree().get_first_node_in_group("PlayerAnimation")

func _ready() -> void:
	set_process(false)
	set_process_input(false)
	visible = false


func _process(delta: float) -> void:
	if Input.is_action_pressed("click"):
		if player.animation != "throw_start":
			# TODO: play_sound(start)
			player.play("throw_start")
		value += delta


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("click"):
		if value < max_value:
			value = 0.0
			return
		set_process(false)
		set_process_input(false)
		# TODO: play_sound(end)
		player.play("throw_end")
		await player.animation_finished
		finished.emit()
		visible = false


func activate() -> void:
	player.play("idle")
	value = 0.0
	set_process(true)
	set_process_input(true)
	visible = true
