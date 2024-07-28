extends Node

@onready var random: AudioStreamPlayer2D = $Random
@onready var timer: Timer = $Timer

const AMBIENT_SOUNDS: Array[AudioStream] = [preload("res://assets/Ambient/PoliceSiren.mp3")] 

func _on_timer_timeout() -> void:
	random.stream = AMBIENT_SOUNDS.pick_random()
	random.play()


func _on_random_finished() -> void:
	timer.wait_time = randi_range(60, 300)
	timer.start()
