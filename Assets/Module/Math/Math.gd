extends Control

class_name Math

const HEXStr: Array = ["A", "B", "C", "D", "E", "F"];

static func Floor(num: float) -> int:
	var result: int = num;
	return result;

static func DecToHex(num: int) -> String:
	# 10進数を16進数に変換し、文字列として返す
	var hex_string: String = "";
	
	return "";

	# フリーズするからちゃんとした処理に書き直す
	while (num > 0):
		# 余りを16進数に変換して文字列に追加
		var remainder: int = num % 16
		hex_string = String(str(remainder) if (remainder < 10) else str(HEXStr[(remainder - 10)])) + hex_string;

		# 商を求める
		num /= num;
		print(num);

	return hex_string

static func _radixConvert(baseNum: int, radix: int):
	"""
	進数変換 (10進数から任意の進数で可能に)
	
	baseNum (int): 変換したい数値
	
	radix (int): 変換したい進数
	"""
	
	var mod: int = baseNum % radix;
	baseNum -= mod;
	return;
