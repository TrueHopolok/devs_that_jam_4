extends Node2D

@export var move_curve: Curve

@onready var constant_movement: ParallaxBackground = $ConstantMovement
@onready var dynamic_movement: ParallaxBackground = $DynamicMovement

var counter : float = 1

func _process(delta: float) -> void:
	constant_movement.scroll_base_offset -= Vector2(100, 0) * delta
	if counter <= 1:
		dynamic_movement.scroll_base_offset -= Vector2(400 * move_curve.sample(counter), 0) * delta
		counter += delta


func move() -> void:
	counter = 0
