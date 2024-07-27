extends AudioStreamPlayer2D

@onready var tracks: Array[AudioStream] = [
	preload("res://assets/temporary/1.mp3"), 
	preload("res://assets/temporary/2.mp3"), 
	preload("res://assets/temporary/3.mp3"),
]

@onready var playNext: Array = range(len(tracks))

func _ready() -> void:
	randomize()
	playNext.shuffle()


func _process(delta : float) -> void:
	_update_play()

func _update_play() -> void:
	if !playing:
		if len(playNext) == 1:
			var notFirst = playNext[0]
			playNext = range(len(tracks))
			playNext.shuffle()
			while notFirst == playNext[0]:
				playNext.shuffle()			
			print(playNext)		
			_play(notFirst)
			return
		_play(playNext.pop_front())

func _play(index: int) -> void:
	stream = tracks[index]
	play()
