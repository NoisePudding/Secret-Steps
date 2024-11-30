extends CharacterBody2D


var is_locked: bool = false

func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	
	if is_locked == false:
		global_position = get_global_mouse_position()
	
	#if Input.is_action_just_pressed("lock"):
		#is_locked = not is_locked
