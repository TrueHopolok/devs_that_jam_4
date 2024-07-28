extends TextureProgressBar

signal finished

@onready var player: AnimatedSprite2D = get_tree().get_first_node_in_group("PlayerAnimation")
@onready var appear: AnimationPlayer = $AnimationPlayer
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var sound_open: Dictionary = {
	true: preload( "res://assets/sounds/others/sound_throw_start.mp3" ),
	false: preload( "res://assets/sounds/others/sound_throw_end.mp3" ),
}

func _ready() -> void:
	set_process(false)
	set_process_input(false)


func _process(delta: float) -> void:
	if Input.is_action_pressed("click"):
		if player.animation != "throw_start":
			audio.stream = sound_open[true]
			audio.play()
			player.play("throw_start")
		value += delta


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("click"):
		if value < max_value:
			value = 0.0
			return
		set_process(false)
		set_process_input(false)
		audio.stream = sound_open[false]
		audio.play()
		player.play("throw_end")
		await player.animation_finished
		appear.play("disappear")
		await appear.animation_finished
		finished.emit()


func activate() -> void:
	player.play("idle")
	value = 0.0
	appear.play("appear")
	await appear.animation_finished
	set_process(true)
	set_process_input(true)
