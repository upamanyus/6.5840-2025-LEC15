package demo

func concurrentExample() {
	x := 0
	y := 0

	go func() {
		x += 1
	}()

	go func() {
		y = 32
		if y == 0 {
			panic("impossible")
		}
		y = foo()
	}()
}
