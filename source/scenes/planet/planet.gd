class_name Planet
extends GravityBody

@export var custom_player_gravity: float = 980
@export var space: Space

func _ready():
    static_body = true

func _on_atmosphere_body_entered(body: Node2D) -> void:
    if body is Spaceship:
        body.on_planet_atmosphere = true


func _on_atmosphere_body_exited(body: Node2D) -> void:
    if body is Spaceship:
        body.on_planet_atmosphere = false


func _on_land_site_body_entered(body: Node2D) -> void:
    if body is Spaceship:
        space.change_gameplay_mode("player")
