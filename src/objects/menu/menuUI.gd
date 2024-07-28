extends MarginContainer

signal finished

@onready var camera: AnimationPlayer = get_tree().get_first_node_in_group("CameraAnimation")


func _ready() -> void:
	camera.animation_finished.connect(func(anim_name: String) -> void:
		if anim_name == "zoomout":
			finished.emit()
			queue_free())

func activate() -> void:
	camera.play("default")


func _on_texture_button_pressed():
	camera.play("zoomout")
	visible = false
