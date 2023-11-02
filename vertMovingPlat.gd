extends StaticBody2D

var speed = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	floating()


func floating():
	position.x += speed
	
	if position.x >= 500:
		speed -= 2
	if position.x <= 0:
		speed += 2
