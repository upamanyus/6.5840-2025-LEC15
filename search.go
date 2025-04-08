// BinarySearch searches for target in a sorted slice and returns the earliest
// position where target is found, or the position where target would appear
// in the sort order; it also returns a bool saying whether the target is
// really found in the slice. The slice must be sorted in increasing order.
func BinarySearch[S ~[]E, E cmp.Ordered](x S, target E) (int, bool) {
	n := len(x)
	i, j := 0, n
	for i < j {
		h := int(uint(i+j) >> 1)
		if cmp.Less(x[h], target) {
			i = h + 1
		} else {
			j = h
		}
	}
	return i, i < n && (x[i] == target || (isNaN(x[i]) && isNaN(target)))
}
