class_name IdleState
extends State

func enter():
    if not state_type:
        state_type = StateMachine.States.IDLE
    parent.animated_sprite.play("idle")

func update(_delta: float) -> void:
    if not parent.on_ground:
        transitioned.emit(state_type, StateMachine.States.JUMP)

    if not parent.linear_velocity.length() < 1. and parent.on_ground:
        transitioned.emit(state_type, StateMachine.States.RUN)
