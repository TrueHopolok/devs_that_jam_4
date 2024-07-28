extends AudioStreamPlayer

@export var enabled_by_default: bool

@onready var tracks: Array[AudioStream] = [
	preload( "res://assets/sounds/music/2moonlight.mp3" ),
	preload( "res://assets/sounds/music/moon3.mp3" ),
	preload( "res://assets/sounds/music/moon4_1.mp3" ),
]
@onready var play_next: Array = range(len(tracks))

func _ready() -> void:
	randomize()
	play_next.shuffle()
	if enabled_by_default:
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


func _on_button_pressed() -> void:
	if playing:
		stop()
	else:
		_on_finished()
