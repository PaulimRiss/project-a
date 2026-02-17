class_name IdleState
extends State

func enter():
    if not state_type:
        state_type = StateMachine.States.IDLE
