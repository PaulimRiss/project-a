extends State

func enter():
    if not state_type:
        state_type = StateMachine.States.JUMP
    parent.animated_sprite.play("jump_up")

func update(_delta: float) -> void:
    if abs(parent.local_vel.y) < 20:
        parent.animated_sprite.play("jump_mid")
    if parent.local_vel.y >= 20:
        parent.animated_sprite.play("jump_down")
    
    if parent.on_ground:
        transitioned.emit(state_type, StateMachine.States.IDLE)