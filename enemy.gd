extends PathFollow2D

# default statistics for this enemy
var speed = 100
var health = 100
var charge = 0
var radius = 5

#temp testing variable, will delete
var timepassed = 0

func _ready():
	offset = 0

func _process(delta):
	offset += speed * delta
	
	#testing 
#	timepassed += delta
#	if timepassed > 0.1:
#		print(health)
#		timepassed -= 0.1
