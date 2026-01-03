extends CharacterBody2D


const SPEED = 300.0
const DASH_SPEED = 1000.0

var is_dashing := false
var dash_direction
var mouse_pos

func _process(delta: float) -> void:

	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_just_pressed("Z"):
		mouse_pos = get_global_mouse_position()
		dash_direction = (mouse_pos - global_position).normalized()
		is_dashing = true
		print(mouse_pos)
	
	var direction := Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	).normalized()
	#if direction:
	if is_dashing:
		velocity = dash_direction * DASH_SPEED

		if (mouse_pos - global_position).length() < 10.0:
			is_dashing = false
		#is_dashing = false
	else:
		velocity = direction * SPEED
	
	move_and_slide()
