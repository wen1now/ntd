extends PathFollow2D

var stats = [100, 100, 0, 5, "godot logo"]

# default statistics for this enemy
var speed = 100
var health = 100
var charge = 0
var radius = 5
var appearance = "godot logo"

#temp testing variable, will delete
var timepassed = 0

func _ready():
	speed = stats[0]
	health = stats[1]
	charge = stats[2]
	radius = stats[3]
	appearance = stats[4]
	offset = 0

func _process(delta):
	offset += speed * delta
	
#	#testing, may be randomly commented in/out
#	timepassed += delta
#	if timepassed > 0.1:
#		print(health)
#		timepassed -= 0.1
