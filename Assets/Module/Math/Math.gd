extends Control

class_name Math

const DigitStr: Array = [
	"0", "1", "2", "3", "4",
	"5", "6", "7", "8", "9",
	"a", "b", "c", "d", "e",
	"f", "g", "h", "i", "j",
	"k", "l", "m", "n", "o",
	"p", "q", "r", "s", "t",
	"u", "v", "w", "x", "y", "z"
];

static func DecToN(dec: int, digit: int) -> String:
	# 対応進数外なら処理終了
	if (digit > 36 || digit < 2):
		printerr("対応外の進数です。");
		return "0";
	
	var ans: Array = [];
	var digit_num: int = 0;
	while(dec > 0):
		# 現在の桁の係数を求める
		digit_num = dec % digit;
		
		# 文字に変換
		ans.push_front(DigitStr[digit_num]);
		
		# 1桁分桁下げ
		dec /= digit;
		
		continue;

	# 文字列が格納された配列を文字列型にする
	var result: String = Vector.join(ans);
	
	return result;
