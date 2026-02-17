class_name StateMachine
extends Node

enum States {
	IDLE,
	RUN,
	JUMP,
	WALL
}

var current_state: State

var animated_sprite: AnimatedSprite2D

var parent: Player

func _ready() -> void:
	await get_parent().ready
	parent = get_parent()

	for child in get_children():
		if child is State:
			child.transitioned.connect(_on_state_transitioned)
	
	current_state = get_child(States.IDLE)
	current_state.enter()

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _on_state_transitioned(state: States, new_state: States):
	if state != (current_state.get_index() as States):
		return
	
	current_state.exit()

	current_state = get_child(new_state)
	current_state.enter()
