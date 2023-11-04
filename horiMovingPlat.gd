extends AnimatableBody2D
@export_category("Platform Properties")
@export var speed = 10
@export var distance = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x -= 70


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	move()


func move():
	position.x += speed


func _on_timer_timeout():
	if speed < 0:
		for n in distance:
			await get_tree().create_timer(0.002).timeout
			speed += 1
	elif speed > 0:
		for n in distance:
			await get_tree().create_timer(0.002).timeout
			speed -= 1
