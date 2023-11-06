extends Area2D
@export_category("Pumpkin Properties")
@export var vert = true
@export var speed = 10
@export var distance = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	if vert == true:
		position.y -= 70
	else:
		position.x -= 70


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if speed < 0:
		rotation -= 0.15
	else:
		rotation += 0.15
	if vert == true:
		position.y += speed
	else:
		position.x += speed


func _on_timer_timeout():
	if vert == true:
		if speed < 0:
			for n in distance:
				await get_tree().create_timer(0.002).timeout
				speed += 1
		elif speed > 0:
			for n in distance:
				await get_tree().create_timer(0.002).timeout
				speed -= 1
	else:
		if speed < 0:
			for n in distance:
				await get_tree().create_timer(0.002).timeout
				speed += 1
		elif speed > 0:
			for n in distance:
				await get_tree().create_timer(0.002).timeout
				speed -= 1
