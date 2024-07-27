extends Node

@onready var random: AudioStreamPlayer2D = $Random
@onready var timer: Timer = $Timer

var amobient_sounds: Array[AudioStream] = [preload("res://assets/temporary/1.mp3")] 

func _on_timer_timeout():
	random.stream = amobient_sounds.pick_random()
	random.play()
	


func _on_random_finished():
	timer.wait_time = randi_range(60, 300)
	timer.start()
