class_name RunState
extends State

func enter():
    if not state_type:
        state_type = StateMachine.States.RUN
    parent.animated_sprite.play("run")

func update(_delta: float) -> void:
    if parent.linear_velocity.length() < 1.:
        transitioned.emit(state_type, StateMachine.States.IDLE)
    if not parent.on_ground:
        transitioned.emit(state_type, StateMachine.States.JUMP)