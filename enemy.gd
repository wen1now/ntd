extends PathFollow2D

# default statistics for this enemy
var speed = 10
var health = 100

func _ready():
	offset = 0

func _process(delta):
	offset += speed * delta
