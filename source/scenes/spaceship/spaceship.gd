class_name Spaceship
extends GravityBody

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var torque_throtle: float = 200
@export var engine_throtle: float = 450
@export var max_speed: float = 320
@export var drag: float = -400

var direction: Vector2 = Vector2.ZERO
var on_planet_atmosphere: bool = false

func _process(_delta: float) -> void:
    direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
    animated_sprite.scale.x = direction.x if direction.x else animated_sprite.scale.x

    if direction.x != 0 and animated_sprite.animation != "turn_right":
        animated_sprite.play("turn_right")
    
    if direction.x == 0 and animated_sprite.animation != "front":
        animated_sprite.play("front")

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
    apply_torque(torque_throtle * direction.x)
    if linear_velocity.length() < max_speed:
        apply_central_force(Vector2(0, engine_throtle * direction.y).rotated(rotation))
    
    var drag_multiplier: float = 1.
    if direction.y == 0:
        drag_multiplier = 0.15
    if on_planet_atmosphere:
        drag_multiplier = .05
        
    apply_central_force(drag * state.linear_velocity.normalized() * drag_multiplier)
    
    super._integrate_forces(state)