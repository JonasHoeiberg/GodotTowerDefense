func filter(array: Array, predicate: FuncRef):
	var returnArray = []
	
	for value in array:
		if !predicate.call(value):
			return
			
		returnArray.append(value)
		
	return returnArray
