class_name Planet
extends GravityBody

@export var custom_player_gravity: float = 980

func _ready():
    static_body = true