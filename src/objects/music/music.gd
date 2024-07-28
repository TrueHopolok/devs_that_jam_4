extends AudioStreamPlayer2D

@export var enabled_by_default: bool

@onready var tracks: Array[AudioStream] = [
	preload("res://assets/temporary/1.mp3"), 
	preload("res://assets/temporary/2.mp3"), 
	preload("res://assets/temporary/3.mp3"),
]
@onready var play_next: Array = range(len(tracks))

func _ready() -> void:
	randomize()
	if enabled_by_default:
		play_next.shuffle()
		stream = tracks[play_next.pop_front()]
		play()


func _on_finished() -> void:
	if len(play_next) == 1:
		var last_track: int = play_next[0]
		play_next = range(len(tracks))
		play_next.shuffle()
		if last_track == play_next[0]:
			play_next[0] = play_next[-1]
			play_next[-1] = last_track
		stream = tracks[last_track]
		play()
		return
	stream = tracks[play_next.pop_front()]
	play()


func _on_button_pressed():
	if playing:
		stop()
	else:
		play_next = range(len(tracks))		
		play_next.shuffle()
		stream = tracks[play_next.pop_front()]
		play()
