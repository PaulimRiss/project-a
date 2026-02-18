class_name GravityBody
extends RigidBody2D

var static_body: bool = false
var interactive_bodies: Array[GravityBody]

func _ready() -> void:
	interactive_bodies = get_parent().interactive_bodies

func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	if static_body:
		return
		
	var total_force: Vector2 = Vector2.ZERO
	for body in interactive_bodies:
		if body != self:
			total_force += calculate_gravitational_force(body)
	
	apply_central_force(total_force)

func calculate_gravitational_force(body: GravityBody) -> Vector2:
	var gravitational_force = mass * body.mass / ((global_position - body.global_position).length() ** 2)
	return gravitational_force * global_position.direction_to(body.global_position) * 10
