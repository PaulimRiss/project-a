class_name StampBook
extends Control

@export var stamper: Sprite2D
@export var stamp_sprite: Sprite2D

var stamp_image: CompressedTexture2D = preload("res://assets/emblem_temp.png")

func _ready():
	MouseHandler.hide_mouse()
	stamper.show()

func _process(_delta):
	stamper.global_position = get_global_mouse_position()


func _on_stamp_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if (event as InputEventMouseButton).is_action_released("left_click"):
			var new_stamp: Sprite2D = stamp_sprite.duplicate()
			new_stamp.texture = stamp_image
			new_stamp.global_position = get_global_mouse_position()
			$Stamps.add_child(new_stamp)
			new_stamp.show()
