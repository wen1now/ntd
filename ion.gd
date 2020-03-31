extends Sprite

var TARGET = "FIRST"
var RANGE = 200
var orthogonal = true


func _ready():
	pass

func can_shoot():
	return $Timer.timeout()

func shoot():
	get_parent().target(self)
