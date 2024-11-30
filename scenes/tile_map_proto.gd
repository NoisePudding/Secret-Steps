extends TileMapLayer


@export var platform: CollisionShape2D

func _ready() -> void:
	self.visible = false
	self.collision_enabled = false

func on_light_entered(_Area2D):
	self.visible = true
	self.collision_enabled = true
	
func on_light_exited(_Area2D):
	self.visible = false
	self.collision_enabled = false
