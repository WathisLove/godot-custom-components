extends Node
class_name HealthComponent


# ===== SIGNALS

signal health_updated(current: float, difference: float)
signal death()


# ===== VARIABLES

@export_range(0, 100, 1, "or_greater") var max_health: float = 0.0: 
	set(value):
		max_health = value
		health = value

var health: float = 0.0


# ===== SETUP

func _ready() -> void:
	assert(max_health > 0)


# ===== METHODS

func damage(amount: float) -> void:
	if health > 0:
		var true_amount = min(health, amount)
		health -= true_amount
		
		health_updated.emit(health, -true_amount)
		if health == 0.0:
			death.emit()
			
		assert(health >= 0.0)


func heal(amount: float) -> void:
	if health < max_health:
		var true_amount = min(max_health - health, amount)
		health += true_amount
		
		health_updated.emit(health, true_amount)
		assert(health <= max_health)
