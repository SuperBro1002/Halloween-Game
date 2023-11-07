extends CharacterBody2D

@export_category("Player Properties")
@export var moveSpeed = 590
@export var midairMoveSpeed = 790
@export var jumpForce = 1050
@export var gravity = 75
@export var dashStep = 35
@export var max_jump_count : int = 2
@export var jump_count : int = 2
@export var maxDashCount = 1
@export var dashCount = 1
@onready var player_sprite = $AnimatedSprite2D
var direction
var dashActive = false
var burned = false
var freeFall = false
var prevDirection
var currentStyle = 0
var ice = false

@export_category("Toggle Functions") # Double jump feature is disable by default (Can be toggled from inspector)
@export var double_jump : = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	movement(delta)
	flip_player()


func movement(delta):
	# Gravity
	if !is_on_floor() and velocity.y < 1480 and dashActive == false:
		velocity.y +=  gravity
	elif is_on_floor():
		dashCount = maxDashCount
		jump_count = max_jump_count
	
	if burned == false and freeFall == false:
		handle_jumping()
		handle_dashing()
	
	if dashActive == false and burned == false and freeFall == false:
		var inputAxis = Input.get_axis("Left", "Right")
		if !is_on_floor():
			velocity = Vector2(inputAxis * midairMoveSpeed, velocity.y)
		elif is_on_floor():
			velocity = Vector2(inputAxis * moveSpeed, velocity.y)
		#position += velocity * delta
		if velocity.x > 0:
			direction = "right"
			dashStep = abs(dashStep)
		elif velocity.x < 0:
			direction = "left"
			dashStep = 0 - abs(dashStep)
	move_and_slide()
	
	if ice == true and velocity.x > 0:
		position.x += 10
	elif ice == true and velocity.x < 0:
		position.x -= 10


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
	velocity.y = (-jumpForce) * 2.00
	# AIDAN'S EDIT: Multiplied velocity.y by 2.15


func dash():
	velocity = Vector2(velocity.x,velocity.y)
	dashActive = true
	velocity.y = 0
	
	for n in 7:
		await get_tree().create_timer(0.002).timeout
		position.x += dashStep
	
	dashActive = false


func flip_player():
	if velocity.x < 0: 
		player_sprite.flip_h = true
	elif velocity.x > 0:
		player_sprite.flip_h = false


func _on_area_2d_area_entered(area):
	burned = true
	prevDirection = get_last_motion().x
	player_sprite.flip_v = true
	if prevDirection > 0:
		velocity = Vector2(-500,-1800)
	elif prevDirection <= 0:
		velocity = Vector2(500,-1800)


func _on_area_2d_area_exited(area):
	await get_tree().create_timer(1.5).timeout
	player_sprite.flip_v = false
	burned = false


func _on_area_2d_2_area_entered(area):
	freeFall = true
	velocity = Vector2(0,600)
	await get_tree().create_timer(0.2).timeout
	player_sprite.flip_v = true
	await get_tree().create_timer(1.5).timeout
	freeFall = false
	player_sprite.flip_v = false


func _on_style_switch_area_entered(area):
	if area.get_collision_layer_value(9) == true:
		$AnimatedSprite2D.frame = 0
	if area.get_collision_layer_value(10) == true:
		$AnimatedSprite2D.frame = 1
	elif area.get_collision_layer_value(11) == true:
		$AnimatedSprite2D.frame = 2
	
	if area.get_collision_layer_value(14) == true:
		maxDashCount = 1
		dashCount = 1
		dashTutorial()
	if area.get_collision_layer_value(15) == true:
		double_jump = true
		jumpTutorial()
	if area.get_collision_layer_value(16) == true:
		get_tree().quit()

func dashTutorial():
	$Label.show()
	await get_tree().create_timer(5).timeout
	$Label.hide()


func jumpTutorial():
	$Label.text = "I can now jump twice without having to touch the ground!"
	$Label.show()
	await get_tree().create_timer(5).timeout
	$Label.hide()

func _on_style_switch_body_entered(body):
	if body.get_collision_layer_value(13) == true:
		ice = true


func _on_style_switch_body_exited(body):
	if body.get_collision_layer_value(13) == true:
		ice = false
