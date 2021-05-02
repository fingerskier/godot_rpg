extends Camera2D

onready var topLeft = $Limits/TopLeft
onready var btmRight = $Limits/BottomRight

func _ready():
	limit_top = topLeft.position.y
	limit_left = topLeft.position.x
	limit_right = btmRight.position.x
	limit_bottom = btmRight.position.y
