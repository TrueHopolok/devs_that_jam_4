extends Area2D

const GRAVITY: float = 200.0
const MIN_SPEED: float = GRAVITY * -2
const MAX_SPEED: float = GRAVITY * 2
const MIN_BORDER: float = -237
const MAX_BORDER: float = 237

var target_position: float = 0.0
var velocity: float = 0.0
var going_up: bool = true

func _ready() -> void:
	set_process(false)
	set_process_input(false)


func _process(delta: float) -> void:
	if going_up:
		velocity -= GRAVITY * delta
	else:
		velocity += GRAVITY * delta
	velocity = clampf(velocity, MIN_SPEED, MAX_SPEED)

	if absf(velocity) >= GRAVITY / 2:
		position.y += (velocity - GRAVITY / 2 * signf(velocity)) * delta
		position.y = clampf(position.y, MIN_BORDER, MAX_BORDER)

	if position.y == MAX_BORDER and velocity > 0.0:
		velocity = 0.0
	elif position.y == MIN_BORDER and velocity < 0.0:
		velocity = 0.0

	if going_up:
		if position.y <= target_position:
			target_position = randf_range(min(position.y + 10, MAX_BORDER), MAX_BORDER)
			going_up = false
			velocity = 0.0
	else:
		if position.y >= target_position:
			target_position = randf_range(MIN_BORDER, max(position.y - 10, MIN_BORDER))
			going_up = true
			velocity = 0.0


func activate() -> void:
	position.y = (MAX_BORDER - MIN_BORDER) / 2
	target_position = randf_range(MIN_BORDER, position.y - 10)
	going_up = true
	set_process(true)
	set_process_input(true)


func deactivate() -> void:
	set_process(false)
	set_process_input(false)

