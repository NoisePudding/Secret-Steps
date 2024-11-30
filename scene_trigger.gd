extends Area2D

@export var player: Node2D
@export var level: String

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		print("aaaaa")
		get_tree().call_deferred("change_scene_to_file", "res://scenes/level_"+level+".tscn")
