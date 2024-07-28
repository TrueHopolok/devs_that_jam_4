extends Camera2D


func _ready() -> void:
	$AnimationPlayer.play("default")
	print(global_position)
