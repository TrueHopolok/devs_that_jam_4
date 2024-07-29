extends Node

@onready var random: AudioStreamPlayer = $Random
@onready var timer: Timer = $Timer

const AMBIENT_SOUNDS: Array[AudioStream] = [
	preload( "res://assets/sounds/ambient/ambient_1.mp3" ),
	preload( "res://assets/sounds/ambient/ambient_2.mp3" ),
	preload( "res://assets/sounds/ambient/ambient_3.mp3" ),
	preload( "res://assets/sounds/ambient/ambient_4.mp3" ),
	preload( "res://assets/sounds/ambient/ambient_5.mp3" ),
	preload( "res://assets/sounds/ambient/ambient_6.mp3" ),
] 

func _on_timer_timeout() -> void:
	random.stream = AMBIENT_SOUNDS.pick_random()
	random.play()


func _on_random_finished() -> void:
	timer.start(randi_range(30, 180))
