class_name State
extends Node

var state_machine: StateMachine
var state_type: StateMachine.States

var parent: Player

func _ready():
	state_machine = get_parent()
	await state_machine.ready
	parent = state_machine.get_parent()

@warning_ignore("UNUSED_SIGNAL")
signal transitioned(current_state: StateMachine.States, new_state: StateMachine.States)

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass