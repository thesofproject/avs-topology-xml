AVSTPLG = avstplg
ALSATPLG = alsatplg
MAKE ?= gmake

export AVSTPLG
export ALSATPLG
export MAKE

SUBDIRS = dmic hda hdmi i2s

all : subdirs

.PHONY : subdirs
subdirs : $(SUBDIRS)

.PHONY : $(SUBDIRS)
$(SUBDIRS) :
	$(MAKE) -C $@

.PHONY : clean
clean :
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir clean; \
	done

install:
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir install; \
	done
