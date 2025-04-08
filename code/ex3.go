package demo

import "sync"

type Raft struct {
	mu           sync.Mutex
	currentTerm int
}

func (rf *Raft) AppendEntries(newTerm int) {
	rf.mu.Lock()

	// ...

	if newTerm > rf.currentTerm {
		rf.currentTerm = newTerm
	}

	// ...
	rf.mu.Unlock()
}

func (rf *Raft) test() {
	go func() {
		rf.AppendEntries(10)
	}()

	go func() {
		rf.AppendEntries(37)
	}()
}

func (rf *Raft) Bad(newTerm int) {
	// ...

	if newTerm > rf.currentTerm {
		rf.mu.Lock()
		rf.currentTerm = newTerm
		rf.mu.Unlock()
	}

	// ...
}
