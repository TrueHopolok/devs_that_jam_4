extends Node2D

@export var move_curve: Curve

@onready var constant_clouds: ParallaxBackground = $ConstantClouds
@onready var dynamic_backgrounds: Array = get_tree().get_nodes_in_group("Dynamic_background")

var counter : float = 1

func _process(delta: float) -> void:
	constant_clouds.scroll_base_offset -= Vector2(100, 0) * delta
	if counter <= 1:
		for background in dynamic_backgrounds:
			background.scroll_base_offset -= Vector2(400 * move_curve.sample(counter), 0) * delta
		counter += delta


func move() -> void:
	counter = 0
