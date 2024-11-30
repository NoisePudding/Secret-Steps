extends Node2D

@export var platform: CollisionShape2D

func _ready() -> void:
	self.visible = false
	platform.set_deferred("disabled",true)

func on_light_entered(_Area2D):
	self.visible = true
	platform.set_deferred("disabled",false)
	
func on_light_exited(_Area2D):
	self.visible = false
	platform.set_deferred("disabled",true)
