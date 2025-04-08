package demo

func foo() int {
	var x int = 10
	x -= 3
	if x > 0 {
		return x
	}
	panic("unreachable")
}
