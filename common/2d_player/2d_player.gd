extends CharacterBody2D
class_name Player2D

# ===== SIGNAL

signal death()


# ===== VARIABLES

@onready var sprite_root: Node2D = $SpriteRoot
@onready var health_bar: SmoothedProgressBar = $SmoothedProgressBar
@onready var movement_animation: AnimationPlayer = $MovementAnimation
@onready var health_animation: AnimationPlayer = $HealthAnimation

@onready var health_component: HealthComponent = $HealthComponent

@export_range(0.0, 500.0, 20.0, "or_greater") var speed: float = 100.0


# ===== METHODS

func _ready() -> void:
	health_component.death.connect(_on_death)


func _process(_delta: float) -> void:
	if health_component.health == 0:
		return
	
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
	
	_play_movement_animation()
	_set_sprite_direction()


func _play_movement_animation() -> void:
	if velocity != Vector2.ZERO:
		movement_animation.play("walk")
	else:
		movement_animation.play("idle")


func _set_sprite_direction() -> void:
	if velocity.x < 0:
		sprite_root.scale = Vector2(-1, 1)
	elif velocity.x > 0:
		sprite_root.scale = Vector2(1, 1)


# ===== SLOTS

func _health_updated(current: float, difference: float) -> void:
	health_bar._on_update_by_value(current, health_component.max_health)
	
	if difference > 0:
		health_animation.play("heal")
	elif difference < 0:
		health_animation.play("damage")


func _on_death() -> void:
	movement_animation.play("death")


func _on_death_animation_finished() -> void:
	death.emit()
