extends CharacterBody2D

# MOVIMENTO
const SPEED := 300.0
const JUMP_VELOCITY := -400.0

# DASH
const DASH_SPEED := 900.0
const DASH_TIME := 0.15

var jumps := 2
var dash_direction: Vector2 = Vector2.RIGHT
var dash_timer := 0.0
var is_dashing := false

var points = 0;

func add_points(val: int):
	print("points: %d" % val)
	points += val

func _physics_process(delta: float) -> void:
	# =========================
	# DASH
	# =========================
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0.0:
			is_dashing = false
			velocity.y = 0
		move_and_slide()
		return


	# =========================
	# GRAVIDADE
	# =========================
	if not is_on_floor():
		velocity += get_gravity() * delta


	# =========================
	# RESET DE PULOS
	# =========================
	if is_on_floor():
		jumps = 2


	# =========================
	# PULO
	# =========================
	if Input.is_action_just_pressed("ui_accept") and jumps > 0:
		velocity.y = JUMP_VELOCITY
		jumps -= 1


	# =========================
	# INPUT DE DIREÇÃO (8 DIREÇÕES)
	# =========================
	var input_direction := Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)

	# Atualiza a direção do dash sempre que houver input
	if input_direction != Vector2.ZERO:
		dash_direction = input_direction.normalized()


	# =========================
	# MOVIMENTO HORIZONTAL NORMAL
	# =========================
	if input_direction.x != 0:
		velocity.x = input_direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


	# =========================
	# ATIVAR DASH (TECLA Z)
	# =========================
	if Input.is_action_just_pressed("Z"):
		is_dashing = true
		dash_timer = DASH_TIME
		velocity = dash_direction * DASH_SPEED


	move_and_slide()
