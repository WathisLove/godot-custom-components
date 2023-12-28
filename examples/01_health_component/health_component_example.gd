extends Node2D

# ===== VARIABLES

@onready var damaging_zone: Area2D = $DamagingZone
@onready var healing_zone: Area2D = $HealingZone
@onready var effect_timer: Timer = $EffectTimer
@onready var player: CharacterBody2D = $Player


# ===== SETUP

func _ready() -> void:
	effect_timer.timeout.connect(_on_timeout)
	
	if player:
		player.death.connect(_on_player_death)


# ===== SLOTS

func _on_timeout() -> void:
	if damaging_zone.get_overlapping_bodies().has(player):
		player.health_component.damage(1)
	elif healing_zone.get_overlapping_bodies().has(player):
		player.health_component.heal(1)


func _on_player_death() -> void:
	get_tree().reload_current_scene()
