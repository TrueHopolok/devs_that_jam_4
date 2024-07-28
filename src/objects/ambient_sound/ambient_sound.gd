extends Node

@onready var random: AudioStreamPlayer2D = $Random
@onready var timer: Timer = $Timer

var amobient_sounds: Array[AudioStream] = [preload("res://assets/Ambient/PoliceSiren.mp3")] 

func _on_timer_timeout() -> void:
	random.stream = amobient_sounds.pick_random()
	random.play()


func _on_random_finished() -> void:
	timer.wait_time = randi_range(60, 300)
	timer.start()
