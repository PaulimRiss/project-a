class_name RunState
extends State

func enter():
    if not state_type:
        state_type = StateMachine.States.RUN
