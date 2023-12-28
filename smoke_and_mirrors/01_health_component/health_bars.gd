extends Node2D

# ===== VARIABLES

@onready var smoothed_progress_bar: SmoothedProgressBar = $BackgroundTileMap/SmoothedProgressBar
@onready var smoothed_progress_bar_2: SmoothedProgressBar = $BackgroundTileMap/SmoothedProgressBar2
@onready var smoothed_progress_bar_3: SmoothedProgressBar = $BackgroundTileMap/SmoothedProgressBar3
@onready var smoothed_progress_bar_4: SmoothedProgressBar = $BackgroundTileMap/SmoothedProgressBar4


var time: float = 0.0

var tween1
var tween2
var tween3
var tween4

# ===== PUBLIC METHODS

func _process(delta: float) -> void:
	time += delta
	
	if time > 2.0 && smoothed_progress_bar.hidden:
		smoothed_progress_bar.show()
		tween1 = create_tween()
		tween1.tween_property(smoothed_progress_bar, "scale", Vector2.ONE, 0.5).set_ease(Tween.EASE_OUT_IN).set_trans(Tween.TRANS_BACK)
	if time > 3.0 && smoothed_progress_bar_2.hidden:
		smoothed_progress_bar_2.show()
		tween2 = create_tween()
		tween2.tween_property(smoothed_progress_bar_2, "scale", Vector2.ONE, 0.5).set_ease(Tween.EASE_OUT_IN).set_trans(Tween.TRANS_BACK)
	if time > 5.0 && smoothed_progress_bar_3.hidden:
		smoothed_progress_bar_3.show()
		tween3 = create_tween()
		tween3.tween_property(smoothed_progress_bar_3, "scale", Vector2.ONE, 0.5).set_ease(Tween.EASE_OUT_IN).set_trans(Tween.TRANS_BACK)
	if time > 6.3 && smoothed_progress_bar_4.hidden:
		smoothed_progress_bar_4.show()
		tween4 = create_tween()
		tween4.tween_property(smoothed_progress_bar_4, "scale", Vector2.ONE, 0.5).set_ease(Tween.EASE_OUT_IN).set_trans(Tween.TRANS_BACK)

