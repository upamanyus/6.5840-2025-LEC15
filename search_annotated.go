// BinarySearch searches for target in a sorted slice and returns the earliest
// position where target is found, or the position where target would appear
// in the sort order; it also returns a bool saying whether the target is
// really found in the slice. The slice must be sorted in increasing order.
func BinarySearch[S ~[]E, E cmp.Ordered](x S, target E) (int, bool) {
	// Inlining is faster than calling BinarySearchFunc with a lambda.
	n := len(x)
	// Define x[-1] < target and x[n] >= target.
	// Invariant: x[i-1] < target, x[j] >= target.
	i, j := 0, n
	for i < j {
		h := int(uint(i+j) >> 1) // avoid overflow when computing h
		// i ≤ h < j
		if cmp.Less(x[h], target) {
			i = h + 1 // preserves x[i-1] < target
		} else {
			j = h // preserves x[j] >= target
		}
	}
	// i == j, x[i-1] < target, and x[j] (= x[i]) >= target  =>  answer is i.
	return i, i < n && (x[i] == target || (isNaN(x[i]) && isNaN(target)))
}
