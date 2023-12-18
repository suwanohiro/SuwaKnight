class_name Vector

static func reverse(array: Array) -> Array:
	var limit: int = array.size() / 2;
	for cnt in range(limit):
		var tmp: String = array[cnt];
		array[cnt] = array[array.size() - 1 - cnt];
		array[array.size() - 1 - cnt] = tmp;
		continue;
	return array;

static func join(array: Array) -> String:
	var result: String = "";
	for cnt in range(array.size()):
		result += str(array[cnt]);
	return result;
