class_name Spaceship
extends GravityBody

@export var torque_throtle: float = 300
@export var engine_throtle: float = 100

var direction: Vector2 = Vector2.ZERO

func _process(_delta: float) -> void:
    direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
    apply_torque(torque_throtle * direction.x)
    apply_central_force(Vector2(0, engine_throtle * direction.y).rotated(rotation))
    
    super._integrate_forces(state)