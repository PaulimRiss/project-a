class_name Player
extends RigidBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var current_planet: Planet

const MAX_SPEED: float = 150
const JUMP_FORCE: float = 600
const ACCELERATION: float = 800
const GRAVITY_ACCELERATION: float = 980
const COYOTE_TIME: float = 0.1

var can_jump: bool = true
var coyote_timer: float = 0.0

var current_normal: Vector2 = Vector2.UP
var last_direction: float = 0


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	angular_velocity = 0
	current_normal = - global_position.direction_to(current_planet.global_position)
	rotate_to_normal()
	
	var on_ground = false
	for i in range(state.get_contact_count()):
		var collider = state.get_contact_collider_object(i)
		if collider == current_planet:
			on_ground = true
			break
	
	if on_ground:
		coyote_timer = COYOTE_TIME
		can_jump = true
	else:
		coyote_timer -= state.step
		if coyote_timer <= 0:
			can_jump = false
	
	if Input.is_action_just_pressed("up") and can_jump:
		var jump_impulse = current_normal * JUMP_FORCE
		apply_central_impulse(jump_impulse)
		can_jump = false
		coyote_timer = 0
	
	var g_force: Vector2 = GRAVITY_ACCELERATION * -current_normal
	apply_central_force(g_force)
	
	movement(state)

func rotate_to_normal() -> void:
	rotation = Vector2.UP.angle_to(current_normal)

func movement(_state: PhysicsDirectBodyState2D) -> void:
	var direction: float = Input.get_axis("left", "right")
	
	var tangent: Vector2 = Vector2.RIGHT.rotated(rotation)
	
	var tangential_speed: float = linear_velocity.dot(tangent)
	
	var g_force: Vector2 = GRAVITY_ACCELERATION * -current_normal
	apply_central_force(g_force)
	
	if direction != 0:
		last_direction = direction
		if abs(tangential_speed) < MAX_SPEED or sign(tangential_speed) != sign(direction):
			apply_central_force(tangent * direction * ACCELERATION)
	else:
		if abs(tangential_speed) > 0:
			var decel_dir = - sign(tangential_speed)
			apply_central_force(tangent * decel_dir * ACCELERATION)
