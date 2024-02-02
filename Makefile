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

dist:
	PWD=`pwd`
	@mkdir -p "$(PWD)/avs-topology"
	@for dir in $(SUBDIRS); do \
		DESTDIR="$(PWD)/avs-topology" $(MAKE) -C $$dir install; \
	done
	@cp LICENSE "$(PWD)/avs-topology/"
	tar -czf avs-topology.tar.gz avs-topology

install:
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir install; \
	done
