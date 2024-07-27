extends Area2D

const GRAVITY: float = 400.0
const MIN_SPEED: float = GRAVITY * -2
const MAX_SPEED: float = GRAVITY *  2
const MIN_BORDER: float = 145
const MAX_BORDER: float = 575

@onready var success_bar: ProgressBar = %SuccessBar

var velocity: float = 0.0

func _ready() -> void:
	set_process(false)
	set_process_input(false)


func _process(delta: float) -> void:
	if Input.is_action_pressed("click"):
		velocity -= GRAVITY * delta
	else:
		velocity += GRAVITY * delta
	velocity = clampf(velocity, MIN_SPEED, MAX_SPEED)

	position.y += velocity * delta
	position.y = clampf(position.y, MIN_BORDER, MAX_BORDER)

	if position.y == MAX_BORDER and velocity > 0.0:
		velocity = 0.0
	elif position.y == MIN_BORDER and velocity < 0.0:
		velocity = 0.0

	if len(get_overlapping_areas()) > 0:
		success_bar.value += delta


func activate():
	velocity = 0.0
	position.y = MAX_BORDER
	success_bar.value = 0.0
	set_process(true)
	set_process_input(true)


func deactivate() -> void:
	set_process(false)
	set_process_input(false)
