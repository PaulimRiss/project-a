class_name Space
extends Node2D

@export var interactive_bodies: Array[GravityBody]

@export var player: Player
@export var spaceship: Spaceship
@export var phantom_camera: PhantomCamera2D

var current_mode: String = "spaceship"

func change_gameplay_mode(mode: String) -> void:
    if current_mode != mode:
        current_mode = mode
        if mode == "player":
            player.global_position = spaceship.global_position
            spaceship.hide()
            player.show()
            phantom_camera.rotate_with_target = true
            phantom_camera.follow_target = player
        elif mode == "spaceship":
            player.hide()
            spaceship.show()
            phantom_camera.rotate_with_target = false
            phantom_camera.follow_target = spaceship
