SRC_DIRS := '.'
ALL_VFILES = $(shell find $(SRC_DIRS) \
							-not -path "./perennial/external/coqutil/etc/coq-scripts/*" \
							-name "*.v")
PROJ_VFILES := $(shell find '.' -name "*.v")

# extract any global arguments for Coq from _CoqProject
COQPROJECT_ARGS := $(shell sed -E -e '/^\#/d' -e "s/'([^']*)'/\1/g" -e 's/-arg //g' _CoqProject)

# user configurable
Q:=@
COQ_ARGS := -noglob
COQC := coqc

default: vo

vo: $(PROJ_VFILES:.v=.vo) update-submodules
vos: $(PROJ_VFILES:.v=.vos) update-submodules
vok: $(PROJ_VFILES:.v=.vok) update-submodules

all: vo

.coqdeps.d: $(ALL_VFILES) _CoqProject | update-submodules
	@echo "COQDEP $@"
	$(Q)coqdep -vos -f _CoqProject $(ALL_VFILES) > $@

# do not try to build dependencies if cleaning
ifeq ($(filter clean,$(MAKECMDGOALS)),)
-include .coqdeps.d
endif

%.vo: %.v _CoqProject | .coqdeps.d
	@echo "COQC $<"
	$(Q)$(COQC) $(COQPROJECT_ARGS) $(COQ_ARGS) -o $@ $<

%.vos: %.v _CoqProject | .coqdeps.d
	@echo "COQC -vos $<"
	$(Q)$(COQC) $(COQPROJECT_ARGS) -vos $(COQ_ARGS) $< -o $@

%.vok: %.v _CoqProject | .coqdeps.d
	@echo "COQC -vok $<"
	$(Q)$(COQC) $(COQPROJECT_ARGS) -vok $(COQ_ARGS) $< -o $@

.PHONY: update-submodules
update-submodules:
	@if [ -d .git/ ] && git submodule status | egrep -q '^[-+]' ; then \
		echo "INFO: Updating git submodules"; \
		git submodule update --init --recursive; \
  fi

.PHONY: goose
goose:
	cd ../goose
	go run ./cmd/goose -dir ../demo/code -out ../demo/generatedcode
	go run ./cmd/proofgen -dir ../demo/code -configdir ../demo/generatedcode -out ../demo/generatedproof
	cd -

clean:
	@echo "CLEAN vo glob aux"
	$(Q)find $(SRC_DIRS) \( -name "*.vo" -o -name "*.vo[sk]" \
		-o -name ".*.aux" -o -name ".*.cache" -name "*.glob" \) -delete
	$(Q)rm -f .timing.sqlite3
	rm -f .coqdeps.d

.PHONY: default
.DELETE_ON_ERROR:
