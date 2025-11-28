extends Node2D

func odd(num):
	var returns = []
	for i in range(num):
		if (num % (i + 1) == 0):
			returns.append(i + 1)
	
	print(returns)
	
	if returns.size() > 2:
		return "no primo"
	else:
		return "primo"

func _ready():
	print(odd(31))  
	print(odd(30))  
