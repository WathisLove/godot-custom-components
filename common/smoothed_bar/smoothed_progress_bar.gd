extends TextureProgressBar
class_name SmoothedProgressBar


# ===== SIGNALS



# ===== VARIABLES

@export var always_show: bool = false
@export var always_hide: bool = false
@export var animate: bool = true
@export var animation_timing: float = 0.8
@export var texture_tint_gradient: GradientTexture1D
@onready var shadow_bar: TextureProgressBar = $ShadowBar

var tween: Tween

# ===== SETUP

func _ready() -> void:
	assert(texture_tint_gradient)
	_set_bar_tint()
	shadow_bar.ratio = ratio
	
	if not always_show or always_hide:
		hide()
	elif always_show:
		show()


# ===== PRIVATE METHODS

func _set_bar_tint() -> void:
	tint_progress = texture_tint_gradient.gradient.sample(ratio)


func _set_bar_visibility() -> void:
	if always_hide or always_show:
		return

	if ratio < 1.0:
		show()
	else:
		hide()


# ===== SLOTS

func _on_update_by_ratio(new_ratio: float) -> void:
	if tween:
		tween.kill()
	
	if !animate:
		shadow_bar.ratio = new_ratio
		ratio = new_ratio
		return
	
	tween = create_tween()
	if ratio < new_ratio:
		shadow_bar.ratio = new_ratio
		tween.tween_property(self, "ratio", new_ratio, animation_timing) \
			.set_trans(Tween.TRANS_CUBIC)
	else:
		ratio = new_ratio
		tween.tween_property(shadow_bar, "ratio", new_ratio, animation_timing) \
			.set_trans(Tween.TRANS_CUBIC)

	
	_set_bar_tint()
	_set_bar_visibility()


func _on_update_by_value(new_val: float, max_val: float) -> void:
	_on_update_by_ratio(new_val / max_val)
