extends StaticBody2D

var state = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	$CollisionShape2D.set_deferred("disabled", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if state == 0:
		show()
		$CollisionShape2D.set_deferred("disabled", false)
		state = 1
	else:
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		state = 0
