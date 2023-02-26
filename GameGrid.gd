extends Node2D

var cellPixelSize = 50

var cells = [[]]

enum SnapAnchor {
	Center
}

func _ready():
	position = Vector2()

# Input provided is global pixel coordinates
func snapPosition(input: Vector2, anchor = SnapAnchor.Center):
	var index = (input - position) / cellPixelSize
	
	index.x = floor(index.x)
	index.y = floor(index.y)
	
	var topLeftCellPosition = index * cellPixelSize
	
	match(anchor):
		SnapAnchor.Center:
			return topLeftCellPosition + (Vector2(cellPixelSize, cellPixelSize) / 2)
