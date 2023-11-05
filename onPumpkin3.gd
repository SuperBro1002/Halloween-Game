extends Area2D

var state = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	show()
	$CollisionShape2D.set_deferred("disabled", false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if state == 1:
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		state = 0
	else:
		show()
		$CollisionShape2D.set_deferred("disabled", false)
		state = 1
