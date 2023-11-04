extends CharacterBody2D

@export_category("Player Properties")
@export var moveSpeed = 490
#AIDAN'S EDIT: Added midairMoveSpeed variable
@export var midairMoveSpeed = 790 #IMPLEMENT
@export var jumpForce = 1050
@export var gravity = 60
@export var dashStep = 20
@export var max_jump_count : int = 2
@export var jump_count : int = 2
@export var maxDashCount = 1
@export var dashCount = 1
var direction
var dashActive = false

@export_category("Toggle Functions") # Double jump feature is disable by default (Can be toggled from inspector)
@export var double_jump : = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement(delta)


func movement(delta):
	# Gravity
	if !is_on_floor() and velocity.y < 880 and dashActive == false:
		velocity.y +=  gravity
	elif is_on_floor():
		dashCount = maxDashCount
		jump_count = max_jump_count
	
	handle_jumping()
	handle_dashing()
	
	if dashActive == false:
		var inputAxis = Input.get_axis("Left", "Right")
			#AIDAN'S EDIT: Added if statement so velocity.x uses midairMoveSpeed in midair
		if !is_on_floor():
			velocity = Vector2(inputAxis * midairMoveSpeed, velocity.y) #IMPLEMENT
		elif is_on_floor():
			velocity = Vector2(inputAxis * moveSpeed, velocity.y) #originally this was the only line, no if statement
		#position += velocity * delta
		if velocity.x > 0:
			direction = "right"
			dashStep = abs(dashStep)
		elif velocity.x < 0:
			direction = "left"
			dashStep = 0 - abs(dashStep)
	move_and_slide()
	


func handle_jumping():
	if Input.is_action_just_pressed("Jump"):
		if is_on_floor() and !double_jump:
			jump()
		elif double_jump and jump_count > 0:
			jump()
			jump_count -= 1


func handle_dashing():
	if Input.is_action_just_pressed("Dash"):
		if !is_on_floor() and dashCount > 0:
			dash()
			dashCount -= 1


func jump():
	velocity.y = (-jumpForce) * 1.90
	# AIDAN'S EDIT: Multiplied velocity.y by 1.90
	#IMPLEMENT


func dash():
	velocity = Vector2(velocity.x,velocity.y)
	dashActive = true
	velocity.y = 0
	
	for n in 7:
		await get_tree().create_timer(0.002).timeout
		position.x += dashStep
	
	dashActive = false

