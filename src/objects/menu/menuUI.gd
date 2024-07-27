extends Control

@onready var camera : AnimationPlayer = get_tree().get_first_node_in_group("CameraAnimation")


func _ready():
	pass

func _on_button_pressed():
	camera.play("zoomout")
