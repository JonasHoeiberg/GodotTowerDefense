extends Node2D

# TODO: Use navigation and tilemap in stead

const debugDraw = true

var cellPixelSize = 50

var cells = {}

enum SnapAnchor {
	Center
}

func _ready():
	position = Vector2()
	
	if debugDraw:
		var distanceRange = 5000
		for x in range(-200, 200):
			addDebugLine(
				Vector2(x * cellPixelSize, distanceRange),
				Vector2(x * cellPixelSize, -distanceRange)
			)
		for y in range(-200, 200):
			addDebugLine(
				Vector2(distanceRange, y * cellPixelSize),
				Vector2(-distanceRange, y * cellPixelSize)
			)
			
func addDebugLine(start: Vector2, end: Vector2):
	var line = Line2D.new()
	line.add_point(start)
	line.add_point(end)
	line.width = 1
	
	add_child(line)
	
func indexToCenter(index: Vector2):
	var topLeftCellPosition = index * cellPixelSize
	
	return topLeftCellPosition + (Vector2(cellPixelSize, cellPixelSize) / 2)
	
func getIndexFromGlobalPosition(input: Vector2):
	var index = (input - position) / cellPixelSize
	
	index.x = floor(index.x)
	index.y = floor(index.y)
	
	return index
	
# Input provided is global pixel coordinates
func snapPosition(input: Vector2):
	var index = getIndexFromGlobalPosition(input)
	
	return indexToCenter(index)

# TODO: Should grid own these nodes? For now just returns the snapped position
func registerAndSnap(item: Node2D):
	var index = getIndexFromGlobalPosition(item.position)
	
	if !(index.x in cells):
		cells[index.x] = {}
		
	cells[index.x][index.y] = item
	
	return indexToCenter(index)

# TODO A*
# TODO Cache results for each cell that has already been calculated
# TODO Recursion or something else that isn't this ugly
# TODO Return null if destination is blocked
# TODO How to handle invalidation on grid state change for already calculated paths
# TODO Handle diagonals
func getGlobalPath(a: Vector2, b: Vector2):
	var aIndex = getIndexFromGlobalPosition(a)
	var bIndex = getIndexFromGlobalPosition(b)
	
	var indexPath = findIndexPath(aIndex, bIndex)
	
	print(indexPath)

func findIndexPath(start: Vector2, goal: Vector2):
	var visited = {}
	
	var queue = [{
		'index': start,
		'parent': null
	}]
	
	while queue.size() > 0:
		var currentNode = queue.pop_front()
		var currentIndex = currentNode['index']
		
		for direction in [Vector2(-1, 0), Vector2(1, 0), Vector2(0, 1), Vector2(0, -1)]:
				var testIndex = currentIndex + direction
				
				if testIndex.x == goal.x and testIndex.y == goal.y:
					return {'index': testIndex, 'parent': currentNode}
					
				if testIndex.x in visited:
					if testIndex.y in visited[testIndex.x]:
						continue
				else:
					visited[testIndex.x] = {}
					
				visited[testIndex.x][testIndex.y] = true
				
				if testIndex.x in cells and testIndex.y in cells[testIndex.x]:
					continue
					
				queue.push_back({'index': testIndex, 'parent': currentNode})
				
	return null
