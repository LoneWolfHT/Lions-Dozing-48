extends Node

var stack = []

func push(val):
	stack.push_back(val)

func pop():
	return stack.pop_back()
