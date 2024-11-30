extends CharacterBody2D

@export_category("Movement Parameters")
@export var jump_peak_time: float =  .7
@export var jump_fall_time: float = .1
@export var jump_height: float = 350
@export var jump_distance: float =  500
@export var coyote_time: float = .5
@export var jump_buffer_time = .1

@onready var coyote_timer: Timer = $CoyoteTimer

@onready var jump_sound: AudioStreamPlayer2D = $jump
@onready var over_sound: AudioStreamPlayer2D = $over

@export var AS: AnimatedSprite2D

@export var checkpoint: Node2D

@onready var death_timer: Timer = $DeathTimer

var speed: float = 500
var jump_velocity: float = 500
var jump_available: bool = true
var jump_buffer:bool = false


var jump_gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var fall_gravity: float = 1000

var is_death: bool = false


func _ready() -> void:
	calculate_movement_parameters()


func calculate_movement_parameters() -> void:
	jump_gravity = (2*jump_height)/pow(jump_peak_time,2)
	fall_gravity = (2*jump_height)/pow(jump_peak_time,2)
	jump_velocity = jump_gravity * jump_peak_time
	speed = jump_distance/(jump_peak_time+jump_fall_time)
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if coyote_timer.is_stopped():
			coyote_timer.start(coyote_time)
		if velocity.y < 0:
			velocity.y += jump_gravity * delta
		elif velocity.y < 500:
			velocity.y += fall_gravity * delta
	else:
		jump_available = true
		coyote_timer.stop()
		if jump_buffer:
			jump()
			jump_buffer = false
	
	if Input.is_action_just_pressed("jump"):
		if jump_available:
			jump()
		else:
			jump_buffer = true
			get_tree().create_timer(jump_buffer_time).timeout.connect(on_jump_buffer_timeout)
	
	if Input.is_action_just_pressed('restart'):
		position = checkpoint.position

	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction
	if velocity.x > 0:
		AS.flip_h = false
	elif velocity.x < 0:
		AS.flip_h = true
	
	
	
	if not is_death:
		move_and_slide()
		handle_animation()

func jump() -> void:
	velocity.y = -jump_velocity
	jump_sound.play()
	jump_available = false


func on_coyote_timer_timeout():
	jump_available = false


func on_jump_buffer_timeout():
	jump_buffer = false

func handle_animation():
	if is_on_floor():
		if velocity:
			AS.play("run")
		else:
			AS.play("idle")
	else:
		AS.play("jump")

func on_spike_entered(area: Area2D):
	if area.name == "spike":
		AS.play("over")
		over_sound.play()
		death_timer.start(1)
		is_death = true
		
	
	
func on_death_timer_timeout():
	death_timer.stop()
	position = checkpoint.position
	is_death = false
#
#
#
#@export var speed = 300
#@export var gravity = 30
#@export var jump_force = 300
#@export var jump_buffer_timer = .1
#var jump_buffer = false
#
#func _physics_process(delta: float) -> void:
	#if !is_on_floor():
		#velocity.y += gravity
		#if velocity.y > 1000:
			#velocity.y = 1000
	#
	#if is_on_floor() and jump_buffer == true:
		#jump()
	#
	#
	#if Input.is_action_just_pressed("jump"):
		#if is_on_floor():
			#jump()
		#elif jump_buffer == false:
			#jump_buffer = true
			#get_tree().create_timer(jump_buffer_timer).timeout.connect(on_jump_buffer_timeout)
		#
	#var horizontal_direction = Input.get_axis("move_left", "move_right")
	#velocity.x = speed * horizontal_direction
	#
	#move_and_slide()
#
#
#func jump() -> void:
	#
	#velocity.y = -jump_force
	#
#func on_jump_buffer_timeout() -> void:
	#jump_buffer = false
