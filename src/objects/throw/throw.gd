extends TextureProgressBar

signal finished

#@onready var player: AnimationPlayer = get_tree().get_first_node_in_group("PlayerAnimation")

func _ready() -> void:
	set_process(false)
	set_process_input(false)
	visible = false


func _process(delta: float) -> void:
	if Input.is_action_pressed("click"):
		value += delta


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("click"):
		if value < max_value:
			# TODO: play_sound(error)
			value = 0.0
			return
		set_process(false)
		set_process_input(false)
		# TODO: 
		# play_sound(throw) IN PLAYER
		# play_animation(throw) IN PLAYER
		# wait till animation finished
		finished.emit()
		visible = false


func activate() -> void:
	value = 0.0
	set_process(true)
	set_process_input(true)
	visible = true
