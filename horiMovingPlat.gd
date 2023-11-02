extends StaticBody2D

var speed = 1
var move = true

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(2).timeout
	for n in 485:
		floatingLeft()
	for n in 85:
		floatingRight()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func floatingLeft():
	speed = -1
	position.y += speed


func floatingRight():
	speed = 1
	position.x += speed
#	if position.x >= 200:
#		speed -= 1
#	if position.x <= 0:
#		speed += 1
