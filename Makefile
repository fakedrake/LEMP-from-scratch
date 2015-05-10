projects = nginx mysql php
dirs = $(sources-dir) $(root-dir)

export dot = $(CURDIR)
export sources-dir = $(dot)/sources
export root-dir = $(dot)/root

$(dirs):
	mkdir -p $@

$(projects):
	$(MAKE) -C $(sources-dir) $@-build

%-clean:
	$(MAKE) -C $(sources-dir) $@
