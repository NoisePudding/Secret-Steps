extends StaticBody2D



@export var platform: CollisionShape2D
@export var visual: MeshInstance2D
#trocar para sprite quando puder ^^^^


func _ready() -> void:
	visual.visible = false
	platform.set_deferred("disabled", true)
		

func on_light_entered(_Area2D):
	visual.visible = true
	platform.set_deferred("disabled", false)
	
func on_light_exited(_Area2D):
	platform.set_deferred("disabled", true)
	visual.visible = false
