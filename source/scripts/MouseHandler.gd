extends Node

@onready var cursor_images: Dictionary[String, CompressedTexture2D] = {
	"arrow": preload("res://assets/cursor_arrow.png")
}

func _ready():
	change_mouse_cursor("arrow")

func change_mouse_cursor(new_cursor: String) -> void:
	Input.set_custom_mouse_cursor(cursor_images[new_cursor])

func hide_mouse() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func show_mouse() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE